#!/bin/bash

# Intentamos sacar el SSID rápido desde /proc/net/wireless o iwgetid si lo tenés
# Si no, nmcli pero filtrando solo lo necesario
SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)

if [ -z "$SSID" ]; then
    # Chequeo rápido de interfaz física sin levantar todo el stack de nmcli
    if ip link show | grep -q "state UP" | grep -v "lo"; then
        SSID="Ethernet"
    else
        SSID="Offline"
    fi
fi

# WARP status: esto es lo que más tarda. 
# Lo ideal es que este script solo corra cuando hacés click o cada 30 seg.
WARP_STATUS=$(warp-cli status | awk '/Status update:/ {print $3}')

if [[ "$SSID" == "Offline" ]]; then
    echo "{\"text\": \"Offline \", \"class\": \"disconnected\"}"
elif [[ "$WARP_STATUS" == "Connected" ]]; then
    echo "{\"text\": \"$SSID\", \"class\": \"warp-connected\"}"
else
    echo "{\"text\": \"$SSID\", \"class\": \"connected\"}"
fi
