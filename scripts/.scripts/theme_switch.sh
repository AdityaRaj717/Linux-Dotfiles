#!/bin/bash

# --- CONFIG ---
WALLPAPER_ROOT="$(realpath "$HOME/Pictures/Wallpapers")"
CACHE_FILE="$HOME/.cache/current_theme"
ROFI_THEME="$HOME/.config/rofi/theme-select.rasi"

# Ensure swww is running
if ! pgrep -x "swww-daemon" > /dev/null; then
    swww-daemon &
    sleep 1
fi

# 1. Generate Theme List with Thumbnails
ROFI_INPUT=""
while IFS= read -r theme; do
    theme_path="$WALLPAPER_ROOT/$theme"
    
    # Find the first image in the folder to act as the "Cover Art"
    cover_image=$(find "$theme_path" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | head -n 1)
    
    # If no image exists, skip or use a placeholder (optional)
    if [ -n "$cover_image" ]; then
        # The ID is the theme name, the Icon is the image
        ROFI_INPUT+="$theme\0icon\x1f$cover_image\n"
    fi
done < <(find -L "$WALLPAPER_ROOT" -mindepth 1 -maxdepth 1 -type d -printf '%P\n' | sort)

# 2. Select Theme
THEME_NAME=$(echo -en "$ROFI_INPUT" | rofi -dmenu -show-icons -theme "$ROFI_THEME" -p "Theme")

[ -z "$THEME_NAME" ] && exit 0

if [[ "$THEME_NAME" == *" "* ]]; then
    notify-send "Error" "Theme folder cannot contain spaces."
    exit 1
fi

THEME_DIR="$WALLPAPER_ROOT/$THEME_NAME"
DEFAULT_WALL=$(find "$THEME_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort | head -n 1)

# Apply
notify-send "Theme" "Applying $THEME_NAME..."
matugen image "$DEFAULT_WALL"
echo "$THEME_NAME" > "$CACHE_FILE"

cp "$HOME/.config/kitty/themes/Matugen.conf" "$HOME/.config/kitty/current-theme.conf"
pkill -USR1 kitty
hyprctl reload

TARGET_THEME_CONFIG="$THEME_DIR/hyprpanel.json"
if [ -f "$TARGET_THEME_CONFIG" ]; then
    hyprpanel useTheme "$TARGET_THEME_CONFIG"
fi

sync
sleep 0.5
swww img "$DEFAULT_WALL" --transition-type grow --transition-fps 165 --transition-step 90
