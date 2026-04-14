#!/bin/bash

browser_cmd=${BROWSER:-firefox}
new_window=false

webs=("  Youtube" "  Gemini" "  WhatsApp" "󰇮  Mail")
mails=("  Personal" "  Work" "󰗚  College" "  Test" "󰴢  Outlook")

while getopts "n" opt; do
    case $opt in
        n) new_window=true ;;
        *) echo "Usage: $0 [-n]"; exit 1 ;;
    esac
done

shift $((OPTIND -1))

open_in_browser(){
    local url="$1"
    if [[ "$new_window" == true && "$browser_cmd" == "firefox" ]]; then
        "$browser_cmd" --new-window "$url"
    else
        "$browser_cmd" "$url"
    fi
}

open_web(){
    read choice
    case "$choice" in
        *Youtube*)  open_in_browser "www.youtube.com" ;;
        *Gemini*)   open_in_browser "https://gemini.google.com/" ;;
        *WhatsApp*) open_in_browser "https://web.whatsapp.com/" ;;
        *Mail*)     open_rofi "Mails" "${mails[@]}" | open_mail ;;
    esac
}

open_mail(){
    read choice
    case "$choice" in
        *Personal*) open_in_browser "https://mail.google.com/mail/u/0/#inbox" ;;
        *Work*)     open_in_browser "https://mail.google.com/mail/u/1/#inbox" ;;
        *College*)  open_in_browser "https://mail.google.com/mail/u/2/#inbox" ;;
        *Test*)     open_in_browser "https://mail.google.com/mail/u/3/#inbox" ;;
        *Outlook*)  open_in_browser "https://outlook.live.com/mail/" ;;
    esac
}

open_rofi(){
    local title="$1"
    shift
    printf "%s\n" "$@" | rofi -dmenu -i -p "$title"
}

open_rofi "Open in $browser_cmd" "${webs[@]}" | open_web
