#!/bin/bash

options=(
    "󰖨  Day"
    "  Night"
)

choice=$(printf "%s\n" "${options[@]}" | rofi -dmenu -i -p "Screen Mode")

killall hyprsunset 2>/dev/null

case "$choice" in
    "󰖨  Day") hyprsunset ;;
    "  Night") hyprsunset -t 4000 -g 65 ;;
esac
