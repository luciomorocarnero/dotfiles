#!/bin/bash

declare -A options=(
    ["  Power Off"]="killall kitty && hyprshutdown -t 'Shutting down...' --post-cmd 'shutdown -P 0'"
    ["  Restart"]="hyprshutdown -t 'Restarting...' --post-cmd 'reboot'"
    ["  Sleep"]="hyprlock & sleep 1 & systemctl suspend"
    ["  Logout"]="hyprctl dispatch exit"
    ["  Lock"]="hyprlock"
)

choice=$(printf "%s\n" "${!options[@]}" | rofi -dmenu -i -p "System:")

if [[ -n "${options[$choice]}" ]]; then
    exec bash -c "${options[$choice]}"
fi
