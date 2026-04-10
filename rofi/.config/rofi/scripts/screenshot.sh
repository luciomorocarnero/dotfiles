#!/bin/bash

dest_options="󰅍  Only Clipboard\n󰅌  Save Picture"
dest_choice=$(echo -e "$dest_options" | rofi -dmenu -i \
        -p "Screenshot" \
        -lines 2 \
        -no-custom \
    -theme-str 'entry { enabled: false; }')

if [[ "$dest_choice" == *"Only Clipboard"* ]]; then
    CLIP_FLAG="--clipboard-only"
    FILENAME_FLAG=""
else
    file_name=$(rofi -dmenu -p "File Name:" \
        -lines 0)

    if [ -z "$file_name" ]; then
        file_name=$(date +"%Y-%m-%d_%H-%M-%S")
    fi

    CLIP_FLAG=""
    FILENAME_FLAG="--filename ${file_name}.png"
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
        hyprshot -m output $CLIP_FLAG $FILENAME_FLAG --output-folder ~/Pictures/ScreenShots
        ;;
    *Window*)
        hyprshot -m window $CLIP_FLAG $FILENAME_FLAG --output-folder ~/Pictures/ScreenShots 
        ;;
    *Region*)
        hyprshot -m region $CLIP_FLAG $FILENAME_FLAG --output-folder ~/Pictures/ScreenShots
        ;;
esac
