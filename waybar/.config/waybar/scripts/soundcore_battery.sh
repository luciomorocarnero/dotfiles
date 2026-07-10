#!/bin/bash

# https://github.com/TheWeirdDev/Bluetooth_Headset_Battery_Level
BATTERY=$(bluetooth_battery 88:0E:85:1A:46:89 2>/dev/null | grep -oP '[0-9]+(?=%)')

if [ -z "$BATTERY" ]; then
    echo "{\"text\": \"\", \"class\": \"disconnected\", \"percentage\": 0}"
else
    # Determine CSS state class based on level
    if [ "$BATTERY" -le 20 ]; then
        STATE="critical"
        TEXT="󰋋 Soundcore ${BATTERY}%"
    elif [ "$BATTERY" -le 30 ]; then
        STATE="warning"
        TEXT="󰋋 Soundcore ${BATTERY}%"
    else
        STATE="normal"
        TEXT="" # An empty string here completely hides the module from Waybar
    fi

    # Return JSON to Waybar
    echo "{\"text\": \"${TEXT}\", \"class\": \"${STATE}\", \"percentage\": ${BATTERY}}"
fi
