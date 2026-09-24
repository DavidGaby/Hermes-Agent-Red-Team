#!/usr/bin/env python3
"""
NetCut++ Web UI - Network Monitoring Dashboard
FastAPI + HTMX + Chart.js - Accessible via ngrok tunnel
Authorized network administration tool
"""

import asyncio
import json
import socket
import subprocess
import threading
import time
from datetime import datetime
from typing import Dict, List, Optional
from contextlib import asynccontextmanager

import netifaces
import scapy.all as scapy
from fastapi import FastAPI, Request, WebSocket, WebSocketDisconnect
from fastapi.responses import HTMLResponse, JSONResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from pydantic import BaseModel

def get_active_interface() -> str:
    try:
        gateways = netifaces.gateways()
        default = gateways.get('default', {})
        if netifaces.AF_INET in default:
            return default[netifaces.AF_INET][1]
    except:
        pass
    return "unknown"

# Global state
class NetworkMonitor:
    def __init__(self):
        self.devices: Dict[str, dict] = {}
        self.scanning = False
        self.scan_thread: Optional[threading.Thread] = None
        self.oui_db = self._load_oui()
        self.active_websockets: List[WebSocket] = []

    def _load_oui(self) -> dict:
        """Load OUI vendor database"""
        return {
            "00:1A:79": "Apple", "00:1B:63": "Apple", "00:1C:B3": "Apple",
            "00:00:0C": "Cisco", "00:01:42": "Cisco", "00:01:63": "Cisco",
            "00:0C:29": "VMware", "00:0C:41": "VMware", "00:0C:66": "VMware",
            "00:16:3E": "Xen/QEMU", "00:50:56": "VMware",
            "B8:27:EB": "Raspberry Pi", "DC:A6:32": "Raspberry Pi",
            "00:1B:21": "Intel", "00:1C:C0": "Intel", "00:1E:67": "Intel",
            "00:22:68": "Dell", "00:23:7D": "Dell", "00:24:E8": "Dell",
            "00:25:64": "Dell", "00:26:B9": "Dell", "00:14:22": "Dell",
            "00:1B:38": "Dell", "00:1C:23": "Dell", "00:1D:09": "Dell",
            "00:1E:4F": "Dell", "00:1F:1E": "Dell", "00:21:70": "Dell",
            "00:22:19": "Dell", "00:23:AE": "Dell", "00:24:2B": "Dell",
            "00:25:64": "Dell", "00:26:2D": "Dell", "00:26:5E": "Dell",
            "00:26:82": "Dell", "00:26:B9": "Dell", "00:27:13": "Dell",
            "00:27:E3": "Dell", "00:28:56": "Dell", "00:29:55": "Dell",
            "00:2A:98": "Dell", "00:2B:67": "Dell", "00:2C:6E": "Dell",
            "00:2D:7E": "Dell", "00:2E:9A": "Dell", "00:2F:8B": "Dell",
        }

    def get_vendor(self, mac: str) -> str:
        if not mac or len(mac) < 8:
            return "Unknown"
        oui = mac.upper()[:8]
        return self.oui_db.get(oui, "Unknown")

    def get_hostname(self, ip: str) -> str:
        try:
            return socket.gethostbyaddr(ip)[0]
        except:
            return ""

    def calculate_network(self, ip: str, netmask: str) -> str:
        ip_parts = list(map(int, ip.split('.')))
        mask_parts = list(map(int, netmask.split('.')))
        return ".".join(str(ip_parts[i] & mask_parts[i]) for i in range(4)) + "/24"

    def get_local_network(self) -> str:
        try:
            gateways = netifaces.gateways()
            default = gateways.get('default', {})
            if netifaces.AF_INET in default:
                gw_ip, iface = default[netifaces.AF_INET]
                addrs = netifaces.ifaddresses(iface)
                if netifaces.AF_INET in addrs:
                    info = addrs[netifaces.AF_INET][0]
                    return self.calculate_network(info['addr'], info['netmask'])
        except:
            pass
        return "192.168.1.0/24"

    def arp_scan(self, network: str) -> List[dict]:
        try:
            arp_req = scapy.ARP(pdst=network)
            broadcast = scapy.Ether(dst="ff:ff:ff:ff:ff:ff")
            packet = broadcast / arp_req
            answered = scapy.srp(packet, timeout=2, verbose=False)[0]
            
            results = []
            for _, received in answered:
                results.append({
                    'ip': received.psrc,
                    'mac': received.hwsrc,
                    'vendor': self.get_vendor(received.hwsrc)
                })
            return results
        except Exception as e:
            print(f"Scan error: {e}")
            return []

    def scan_loop(self):
        while self.scanning:
            try:
                network = self.get_local_network()
                devices = self.arp_scan(network)
                now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                
                for d in devices:
                    ip = d['ip']
                    hostname = self.get_hostname(ip)
                    if ip in self.devices:
                        self.devices[ip].update({
                            'mac': d['mac'],
                            'vendor': d['vendor'],
                            'hostname': hostname,
                            'last_seen': now
                        })
                    else:
                        self.devices[ip] = {
                            'mac': d['mac'],
                            'vendor': d['vendor'],
                            'hostname': hostname,
                            'last_seen': now,
                            'first_seen': now
                        }
                
                # Cleanup old devices (>60s not seen)
                cutoff = time.time() - 60
                to_remove = [ip for ip, d in self.devices.items() 
                           if (datetime.now() - datetime.strptime(d['last_seen'], "%Y-%m-%d %H:%M:%S")).total_seconds() > 60]
                for ip in to_remove:
                    del self.devices[ip]
                
                # Broadcast update
                asyncio.run(self.broadcast_update())
                
            except Exception as e:
                print(f"Scan loop error: {e}")
            time.sleep(3)

    def start_scan(self):
        if not self.scanning:
            self.scanning = True
            self.scan_thread = threading.Thread(target=self.scan_loop, daemon=True)
            self.scan_thread.start()

    def stop_scan(self):
        self.scanning = False

    async def broadcast_update(self):
        data = self.get_devices_json()
        for ws in self.active_websockets[:]:
            try:
                await ws.send_text(json.dumps({"type": "devices", "data": data}))
            except:
                self.active_websockets.remove(ws)

    def get_devices_json(self) -> List[dict]:
        return [
            {"ip": ip, **d} for ip, d in sorted(self.devices.items())
        ]

monitor = NetworkMonitor()

@asynccontextmanager
async def lifespan(app: FastAPI):
    monitor.start_scan()
    yield
    monitor.stop_scan()

app = FastAPI(title="NetCut++ Web Dashboard", lifespan=lifespan)
templates = Jinja2Templates(directory="templates")

class ScanRequest(BaseModel):
    action: str

@app.get("/", response_class=HTMLResponse)
async def dashboard(request: Request):
    return templates.TemplateResponse(request=request, name="dashboard.html")

@app.get("/api/devices")
async def get_devices():
    return {"devices": monitor.get_devices_json()}

@app.post("/api/scan")
async def control_scan(req: ScanRequest):
    if req.action == "start":
        monitor.start_scan()
        return {"status": "scanning"}
    elif req.action == "stop":
        monitor.stop_scan()
        return {"status": "stopped"}
    return {"error": "invalid action"}


@app.get("/api/network-info")
async def network_info():
    return {
        "network": monitor.get_local_network(),
        "subnet": monitor.get_local_network(),
        "interface": get_active_interface()
    }


@app.websocket("/ws")
async def websocket_endpoint(websocket: WebSocket):
    await websocket.accept()
    monitor.active_websockets.append(websocket)
    try:
        # Send initial data
        await websocket.send_text(json.dumps({
            "type": "devices", 
            "data": monitor.get_devices_json()
        }))
        while True:
            await websocket.receive_text()
    except WebSocketDisconnect:
        if websocket in monitor.active_websockets:
            monitor.active_websockets.remove(websocket)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)