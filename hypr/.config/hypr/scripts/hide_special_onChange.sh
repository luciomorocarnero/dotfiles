#!/bin/bash
# hide_special_onChange.sh

SPECIAL_NAME=$(hyprctl monitors -j | jq '(.[] | select(.focused == true)).specialWorkspace.name' | cut -d':' -f2 | cut -d'"' -f1)

if [ "$SPECIAL_NAME" != "" ]; then
    hyprctl dispatch togglespecialworkspace $SPECIAL_NAME
fi
