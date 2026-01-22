#!/bin/bash

# Optimized theme switcher with faster directory scanning

WALLPAPER_ROOT="$HOME/Pictures/Wallpapers"
CACHE_FILE="$HOME/.cache/current_theme"
ROFI_THEME="$HOME/.config/rofi/theme-select.rasi"

# Ensure swww daemon is running (check once)
pgrep -x swww-daemon >/dev/null || { swww-daemon & sleep 0.5; }

# Build theme list efficiently with single find command
mapfile -t themes < <(find -L "$WALLPAPER_ROOT" -mindepth 1 -maxdepth 1 -type d -printf '%P\n' | sort)

# Build rofi input
ROFI_INPUT=""
for theme in "${themes[@]}"; do
    # Use -quit to stop after finding first image (faster)
    cover_image=$(find "$WALLPAPER_ROOT/$theme" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -print -quit)
    [ -n "$cover_image" ] && ROFI_INPUT+="$theme\0icon\x1f$cover_image\n"
done

# Show rofi and get selection
THEME_NAME=$(echo -en "$ROFI_INPUT" | rofi -dmenu -show-icons -theme "$ROFI_THEME" -p "Theme")
[ -z "$THEME_NAME" ] && exit 0

# Validate theme name (no spaces)
[[ "$THEME_NAME" == *" "* ]] && { notify-send "Error" "Theme folder cannot contain spaces."; exit 1; }

# Get first wallpaper (using -quit for speed)
THEME_DIR="$WALLPAPER_ROOT/$THEME_NAME"
DEFAULT_WALL=$(find "$THEME_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -print -quit)

# Apply theme (batch operations)
notify-send "Theme" "Applying $THEME_NAME..."

# Generate colors
matugen image "$DEFAULT_WALL" >/dev/null 2>&1

# Update cache and kitty in one go
{
    echo "$THEME_NAME" > "$CACHE_FILE"
    cp "$HOME/.config/kitty/themes/Matugen.conf" "$HOME/.config/kitty/current-theme.conf"
    pkill -USR1 kitty
} &

# Apply hyprpanel theme if exists
TARGET_THEME_CONFIG="$THEME_DIR/hyprpanel.json"
[ -f "$TARGET_THEME_CONFIG" ] && hyprpanel useTheme "$TARGET_THEME_CONFIG" &

# Reload hyprland and set wallpaper (parallel)
hyprctl reload &
swww img "$DEFAULT_WALL" --transition-type grow --transition-fps 60 --transition-step 90 &

wait
