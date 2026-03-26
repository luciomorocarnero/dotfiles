#!/bin/bash

# If there isn't a file, do:
# curl -s https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/glyphnames.json | \
# jq -r 'to_entries | .[] | "\(.value.char) \(.key)"' > ~/.local/share/nerdfonts_list.txt
ICON_FILE="$HOME/.local/share/nerdfonts_list.txt"

selected=$(cat "$ICON_FILE" | rofi -dmenu -i -p "NerdFonts:" | awk '{print $1}')

# Copy to Clipboard
if [ ! -z "$selected" ]; then
    echo -n "$selected" | wl-copy
fi
