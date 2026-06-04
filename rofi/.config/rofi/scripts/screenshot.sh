#!/bin/bash

dest_options=("󰅍  Only Clipboard" "󰅌  Save Picture")
mode_options=("󰹑  Full Screen" "󱂬  Active Window" "󰒅  Selected Region")

run_rofi(){
    local title="$1"
    local lines="$2"
    shift 2
    printf "%s\n" "$@" | rofi -dmenu -i -p "$title" -lines "$lines" -no-custom -theme-str 'entry { enabled: false; }'
}

take_shot(){
    read -r mode_choice

    [ -z "$mode_choice" ] && exit 0

    case "$mode_choice" in
        *Full*)   mode="output" ;;
        *Window*) mode="window" ;;
        *Region*) mode="region" ;;
    esac

    hyprshot -m "$mode" "${SHOT_FLAGS[@]}" --output-folder "$HOME/Pictures/ScreenShots"
}

dest_choice=$(run_rofi "Screenshot" 2 "${dest_options[@]}")
[ -z "$dest_choice" ] && exit 0

# Initialize an empty array for flags
SHOT_FLAGS=()

if [[ "$dest_choice" == *"Only Clipboard"* ]]; then
    SHOT_FLAGS+=("--clipboard-only")
else
    file_name=$(rofi -dmenu -p "File Name (Enter for date):" -lines 0)
    if [ -z "$file_name" ]; then
        file_name=$(date +"%Y-%m-%d_%H-%M-%S")
    fi
    SHOT_FLAGS+=("--filename" "${file_name}.png")
fi

run_rofi "Mode" 3 "${mode_options[@]}" | take_shot
