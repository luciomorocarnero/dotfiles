#!/usr/bin/env bash

WALLPAPER_DIR="${2:-$HOME/Pictures/Wallpapers}"

if [[ "$1" == "-r" || "$1" == "--random" ]]; then
    filename=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -printf "%f\n" | shuf -n 1)
else
    filename=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -printf "%f\n" | \
        rofi -dmenu -i -p "Select Wallpaper")
fi

if [[ -n "$filename" ]]; then
    full_path="$WALLPAPER_DIR/$filename"
    [[ -f "$full_path" ]] && awww img -t wipe --transition-duration 1 "$full_path"
fi
