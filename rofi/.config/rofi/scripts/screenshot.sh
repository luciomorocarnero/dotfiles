#!/bin/bash

# Opciones
dest_options=("󰅍  Only Clipboard" "󰅌  Save Picture")
mode_options=("󰹑  Full Screen" "󱂬  Active Window" "󰒅  Selected Region")

run_rofi(){
    local title="$1"
    local lines="$2"
    shift 2
    printf "%s\n" "$@" | rofi -dmenu -i -p "$title" -lines "$lines" -no-custom -theme-str 'entry { enabled: false; }'
}

take_shot(){
    read mode_choice

    [ -z "$mode_choice" ] && exit 0

    case "$mode_choice" in
        *Full*)   mode="output" ;;
        *Window*) mode="window" ;;
        *Region*) mode="region" ;;
    esac

    hyprshot -m "$mode" $CLIP_FLAG $FILENAME_FLAG --output-folder ~/Pictures/ScreenShots
}

dest_choice=$(run_rofi "Screenshot" 2 "${dest_options[@]}")
[ -z "$dest_choice" ] && exit 0

if [[ "$dest_choice" == *"Only Clipboard"* ]]; then
    CLIP_FLAG="--clipboard-only"
    FILENAME_FLAG=""
else
    file_name=$(rofi -dmenu -p "File Name (Enter for date):" -lines 0)
    if [ -z "$file_name" ]; then
        file_name=$(date +"%Y-%m-%d_%H-%M-%S")
    fi
    CLIP_FLAG=""
    FILENAME_FLAG="--filename ${file_name}.png"
fi

run_rofi "Mode" 3 "${mode_options[@]}" | take_shot
