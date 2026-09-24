# Hermes-Agent-Red-Team

Autonomous network intelligence platform with real-time ARP scanning, WebSocket dashboard, device fingerprinting (OUI/hostname/RSSI), MySQL-backed logging, and red team audit modules. Built for authorized network assessment & infrastructure hardening.

## Features
- **Real-time ARP Scanning** — Continuous network discovery every 3s
- **Live Dashboard** — FastAPI + WebSocket + Tailwind CSS dark mode
- **Device Intelligence** — Vendor OUI lookup, hostname resolution, signal strength (dBm)
- **Network Topology** — SSID detection, interface mapping, VLAN awareness
- **Export & Log** — CSV export, MySQL persistence (gaby_vault)
- **Audit Modules** — Authorized assessment tooling hooks

## Tech Stack
- **Backend:** Python 3.9+, FastAPI, Scapy, netifaces
- **Frontend:** HTML5, Tailwind CSS, Vanilla JS (WebSockets)
- **Database:** MySQL 8.0 (gaby_vault schema)
- **Infrastructure:** Tailscale mesh, systemd services

## Quick Start
```bash
# Dependencies
pip install -r requirements.txt

# Run with root (required for ARP/raw sockets)
sudo python3 netcut_web.py

# Access dashboard
# Local: http://localhost:8000
# Remote: http://<tailscale-ip>:8000
```

## Legal
Authorized network assessment tool only. Deploy only on networks you own or have explicit written permission to test. Unauthorized scanning/disruption may violate computer fraud laws.

## License
MIT License — see [LICENSE](LICENSE)