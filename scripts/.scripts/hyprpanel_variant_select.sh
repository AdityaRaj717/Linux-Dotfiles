#!/bin/bash

# --- CONFIG ---
WALLPAPER_ROOT="$HOME/Pictures/Wallpapers"
CACHE_FILE="$HOME/.cache/current_theme"
ROFI_THEME="$HOME/.config/rofi/hyprpanel-select.rasi"

# 1. Read Current Theme
if [ ! -f "$CACHE_FILE" ]; then
    notify-send "Error" "No theme set. Please select a wallpaper theme first."
    exit 1
fi

CURRENT_THEME=$(cat "$CACHE_FILE")
THEME_DIR="$WALLPAPER_ROOT/$CURRENT_THEME"

# 2. Check if theme directory exists
if [ ! -d "$THEME_DIR" ]; then
    notify-send "Error" "Theme directory not found: $THEME_DIR"
    exit 1
fi

# 3. Find all HyprPanel JSON files in the current theme
mapfile -t VARIANTS < <(find "$THEME_DIR" -type f -name "*.json" -printf '%f\n' | sed 's/\.json$//' | sort)

if [ ${#VARIANTS[@]} -eq 0 ]; then
    notify-send "HyprPanel" "No theme variants found in $CURRENT_THEME"
    exit 1
fi

# 4. Select Variant
SELECTED=$(printf '%s\n' "${VARIANTS[@]}" | rofi -dmenu -theme "$ROFI_THEME" -p "HyprPanel Style")

[ -z "$SELECTED" ] && exit 0

# 5. Apply Selected Variant
VARIANT_FILE="$THEME_DIR/${SELECTED}.json"

if [ -f "$VARIANT_FILE" ]; then
    notify-send "HyprPanel" "Applying style: $SELECTED"
    hyprpanel useTheme "$VARIANT_FILE"
    
    # Optional: Save current variant to cache for future reference
    echo "$SELECTED" > "$HOME/.cache/current_hyprpanel_variant"
else
    notify-send "Error" "Variant file not found: $VARIANT_FILE"
    exit 1
fi
