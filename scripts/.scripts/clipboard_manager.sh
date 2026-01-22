#!/bin/bash

# Optimized clipboard manager

ROFI_THEME="$HOME/.config/rofi/clipboard.rasi"

# Check cliphist (fail fast)
command -v cliphist >/dev/null || { notify-send "Error" "cliphist not installed" -u critical; exit 1; }

# Show history and copy selection
cliphist list | 
rofi -dmenu -theme "$ROFI_THEME" -p "Clipboard" |
cliphist decode |
wl-copy && notify-send "Clipboard" "Copied" -t 1000
