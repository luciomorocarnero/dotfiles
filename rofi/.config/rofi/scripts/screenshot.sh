#!/bin/bash

dest_options="󰅍  Only Clipboard\n󰅌  Save Picture"
dest_choice=$(echo -e "$dest_options" | rofi -dmenu -i \
        -p "Screenshot" \
        -lines 2 \
        -no-custom \
    -theme-str 'entry { enabled: false; }')

if [[ "$dest_choice" == *"Only Clipboard"* ]]; then
    CLIP_FLAG="--clipboard-only"
else
    CLIP_FLAG=""
fi

[ -z "$dest_choice" ] && exit 0

mode_options="󰹑  Full Screen\n󱂬  Active Window\n󰒅  Selected Region"
mode_choice=$(echo -e "$mode_options" | rofi -dmenu -i \
        -p "Mode" \
        -lines 3 \
        -no-custom \
    -theme-str 'entry { enabled: false; }')

case "$mode_choice" in
    *Full*)
        hyprshot -m output $CLIP_FLAG
        ;;
    *Window*)
        hyprshot -m window $CLIP_FLAG
        ;;
    *Region*)
        hyprshot -m region $CLIP_FLAG
        ;;
esac
