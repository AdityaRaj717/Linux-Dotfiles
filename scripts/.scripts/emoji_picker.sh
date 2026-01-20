#!/bin/bash

# Emoji picker with rofi
# Copies selected emoji to clipboard

# Check if rofi-emoji is available
if ! command -v rofi &> /dev/null; then
    notify-send "Error" "rofi is not installed"
    exit 1
fi

# Launch emoji picker
rofi -modi emoji -show emoji -theme ~/.config/rofi/emoji.rasi
