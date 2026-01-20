#!/bin/bash

# Clipboard history manager with rofi
# Shows clipboard history and allows selection

# Check if cliphist is installed
if ! command -v cliphist &> /dev/null; then
    notify-send "Error" "cliphist is not installed"
    exit 1
fi

# Show clipboard history with rofi
selected=$(cliphist list | rofi -dmenu -theme ~/.config/rofi/clipboard.rasi -p "Clipboard")

# If something was selected, decode and copy to clipboard
if [ -n "$selected" ]; then
    echo "$selected" | cliphist decode | wl-copy
    notify-send "Clipboard" "Copied to clipboard" -t 1500
fi
