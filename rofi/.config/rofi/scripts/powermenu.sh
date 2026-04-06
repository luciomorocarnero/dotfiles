#!/bin/bash

options=(
    "  Power Off"
    "  Restart"
    "  Sleep"
    "  Logout"
    "  Lock"
)

choice=$(printf "%s\n" "${options[@]}" | rofi -dmenu -i -p "System:")

case "$choice" in
    "  Power Off") systemctl poweroff ;;
    "  Restart") systemctl reboot ;;
    "  Sleep")
        hyprlock &
        sleep 1
        systemctl suspend
        ;;
    "  Logout") hyprctl dispatch exit ;;
    "  Lock") hyprlock ;;
esac
