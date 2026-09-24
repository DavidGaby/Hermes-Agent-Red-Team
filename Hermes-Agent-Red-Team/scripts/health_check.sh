#!/bin/bash
# Hermes system health watchdog — checks every 30m
# If gateway is down, restart 9router automatically

GATEWAY="http://localhost:20128/v1/models"
STATUS=$(curl -s -m 5 "$GATEWAY" 2>/dev/null | grep -c '"id"' 2>/dev/null || echo 0)

if [ "$STATUS" -eq 0 ]; then
    echo "9router gateway DOWN — restarting"
    pm2 restart 9router-server 2>/dev/null
    sleep 5
    STATUS2=$(curl -s -m 10 "$GATEWAY" 2>/dev/null | grep -c '"id"' || echo 0)
    echo "Gateway recovery: $STATUS2 models available"
else
    echo "[SILENT]"
fi
PY

chmod +x ~/.hermes/scripts/health_check.sh
