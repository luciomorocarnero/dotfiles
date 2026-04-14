#!/bin/bash

options=(
    "  Power Off"
    "  Restart"
    "  Sleep"
    "  Logout"
    "  Lock"
)

run_rofi(){
    local title="$1"
    shift
    printf "%s\n" "$@" | rofi -dmenu -i -p "$title"
}

handle_system(){
    read choice
    case "$choice" in
        *"Power Off"*) systemctl poweroff ;;
        *"Restart"*)   systemctl reboot ;;
        *"Sleep"*)
            hyprlock &
            sleep 1
            systemctl suspend
            ;;
        *"Logout"*)    hyprctl dispatch exit ;;
        *"Lock"*)      hyprlock ;;
    esac
}

run_rofi "System" "${options[@]}" | handle_system
