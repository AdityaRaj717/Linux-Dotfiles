#!/bin/bash

# Optimized emoji picker using rofi-emoji plugin

ROFI_THEME="$HOME/.config/rofi/emoji.rasi"

# Launch emoji picker directly
rofi -modi emoji -show emoji -theme "$ROFI_THEME"
