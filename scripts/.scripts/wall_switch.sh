#!/bin/bash

# Optimized wallpaper selector with thumbnail caching & "Latest First" sorting

WALLPAPER_ROOT="$HOME/Pictures/Wallpapers"
CACHE_FILE="$HOME/.cache/current_theme"
ROFI_THEME="$HOME/.config/rofi/wallpaper-select.rasi"
REFRESH_THUMB="$HOME/.cache/thumbs/refresh.svg"

# Define state directory for remembering wallpapers
STATE_DIR="$HOME/.cache/theme_state"
mkdir -p "$STATE_DIR"

# Read current theme
[ ! -f "$CACHE_FILE" ] && { notify-send "Error" "No theme set."; exit 1; }
CURRENT_THEME=$(cat "$CACHE_FILE")

# Target the wallpapers subfolder
THEME_DIR="$WALLPAPER_ROOT/$CURRENT_THEME/wallpapers"
# Separate thumbnail cache per theme
THUMB_DIR="$HOME/.cache/thumbs/wallpapers/$CURRENT_THEME"

# Create cache directory if it doesn't exist
mkdir -p "$THUMB_DIR"

# Validate directory
[ ! -d "$THEME_DIR" ] && { notify-send "Error" "Wallpaper directory not found."; exit 1; }

# Generate thumbnails function
generate_thumbs() {
    notify-send -t 2000 "Wallpaper Menu" "Generating thumbnails for $CURRENT_THEME..."
    
    # Use parallel processing
    find "$THEME_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -print0 | 
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
    
    # UPDATED: Find files, print with timestamp, sort descending, cut timestamp, read line by line
    find "$THEME_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -printf "%T@\t%p\n" | 
    sort -nr | 
    cut -f2- | 
    while read -r file; do
        filename=$(basename "$file")
        thumb_path="$THUMB_DIR/${filename}.jpg"
        icon="${thumb_path}"
        
        # Fallback icon if thumb generation failed or hasn't run yet
        [ ! -f "$thumb_path" ] && icon="image-x-generic"
        
        echo -e "$file\0icon\x1f$icon"
    done
} | rofi -dmenu -show-icons -theme "$ROFI_THEME" -p "Wallpaper" | {
    read -r SELECTED
    
    # Handle selection
    [ -z "$SELECTED" ] && exit 0
    [[ "$SELECTED" == "Refresh Thumbnails" ]] && { "$0" refresh; exit 0; }
    
    # UPDATED: Save the selected wallpaper to state file
    echo "$SELECTED" > "$STATE_DIR/${CURRENT_THEME}.wall"

    # Apply wallpaper
    swww img "$SELECTED" --transition-type wipe --transition-fps 60 --transition-step 12 --transition-duration 3
}
