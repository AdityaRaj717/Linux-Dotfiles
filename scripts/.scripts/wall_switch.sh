#!/bin/bash

# Optimized wallpaper selector with thumbnail caching

WALLPAPER_ROOT="$HOME/Pictures/Wallpapers"
CACHE_FILE="$HOME/.cache/current_theme"
ROFI_THEME="$HOME/.config/rofi/wallpaper-select.rasi"
THUMB_DIR="$HOME/.cache/thumbs/wallpapers"
REFRESH_THUMB="$HOME/.cache/thumbs/refresh.svg"

# Create cache directory once
mkdir -p "$THUMB_DIR"

# Read current theme
[ ! -f "$CACHE_FILE" ] && { notify-send "Error" "No theme set."; exit 1; }
CURRENT_THEME=$(cat "$CACHE_FILE")
THEME_DIR="$WALLPAPER_ROOT/$CURRENT_THEME"

# Generate thumbnails function
generate_thumbs() {
    notify-send -t 2000 "Wallpaper Menu" "Generating thumbnails..."
    
    # Use parallel processing with xargs for speed
    find "$THEME_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -print0 | 
    xargs -0 -P 4 -I {} bash -c '
        filename=$(basename "{}")
        thumb_path="'"$THUMB_DIR"'/${filename}.jpg"
        [ ! -f "$thumb_path" ] && magick "{}" -resize 384x216^ -gravity center -extent 384x216 "$thumb_path" 2>/dev/null
    '
    
    notify-send -t 1500 "Wallpaper Menu" "Thumbnails ready!"
}

# Handle refresh argument
[ "$1" = "refresh" ] && { generate_thumbs; exec "$0"; }

# Build rofi input efficiently
{
    echo -e "Refresh Thumbnails\0icon\x1f$REFRESH_THUMB"
    find "$THEME_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -print0 |
    while IFS= read -r -d '' file; do
        filename=$(basename "$file")
        thumb_path="$THUMB_DIR/${filename}.jpg"
        icon="${thumb_path}"
        [ ! -f "$thumb_path" ] && icon="image-x-generic"
        echo -e "$file\0icon\x1f$icon"
    done
} | rofi -dmenu -show-icons -theme "$ROFI_THEME" -p "Wallpaper" | {
    read -r SELECTED
    
    # Handle selection
    [ -z "$SELECTED" ] && exit 0
    [[ "$SELECTED" == "Refresh Thumbnails" ]] && { "$0" refresh; exit 0; }
    
    # Apply wallpaper with optimized transition
    swww img "$SELECTED" --transition-type wipe --transition-fps 60 --transition-step 255
}
