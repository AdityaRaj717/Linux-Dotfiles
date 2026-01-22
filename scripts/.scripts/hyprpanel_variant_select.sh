#!/bin/bash

# Optimized HyprPanel variant selector

WALLPAPER_ROOT="$HOME/Pictures/Wallpapers"
CACHE_FILE="$HOME/.cache/current_theme"
ROFI_THEME="$HOME/.config/rofi/hyprpanel-select.rasi"

# Read current theme (fail fast)
[ ! -f "$CACHE_FILE" ] && { notify-send "Error" "No theme set."; exit 1; }
CURRENT_THEME=$(cat "$CACHE_FILE")
THEME_DIR="$WALLPAPER_ROOT/$CURRENT_THEME"

# Validate theme directory
[ ! -d "$THEME_DIR" ] && { notify-send "Error" "Theme directory not found."; exit 1; }

# Find variants efficiently
mapfile -t VARIANTS < <(find "$THEME_DIR" -type f -name "*.json" -printf '%f\n' | sed 's/\.json$//' | sort)
[ ${#VARIANTS[@]} -eq 0 ] && { notify-send "HyprPanel" "No variants found."; exit 1; }

# Select variant
SELECTED=$(printf '%s\n' "${VARIANTS[@]}" | rofi -dmenu -theme "$ROFI_THEME" -p "HyprPanel Style")
[ -z "$SELECTED" ] && exit 0

# Apply variant
VARIANT_FILE="$THEME_DIR/${SELECTED}.json"
if [ -f "$VARIANT_FILE" ]; then
    notify-send "HyprPanel" "Applying: $SELECTED" -t 1500
    hyprpanel useTheme "$VARIANT_FILE"
    echo "$SELECTED" > "$HOME/.cache/current_hyprpanel_variant"
else
    notify-send "Error" "Variant not found." -u critical
    exit 1
fi
