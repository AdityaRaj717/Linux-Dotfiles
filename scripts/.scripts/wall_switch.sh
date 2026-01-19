#!/bin/bash

# --- CONFIG ---
WALLPAPER_ROOT="$HOME/Pictures/Wallpapers"
CACHE_FILE="$HOME/.cache/current_theme"
# This matches the path in your requested command
ROFI_THEME="$HOME/.config/rofi/wallpaper-select.rasi"
THUMB_DIR="$HOME/.cache/thumbs/wallpapers"
REFRESH_THUMB="$HOME/.cache/thumbs/refresh.svg"

# Create thumbs dir
mkdir -p "$THUMB_DIR"

# 1. Read Current Theme
if [ ! -f "$CACHE_FILE" ]; then
    notify-send "Error" "No theme set."
    exit 1
fi

CURRENT_THEME=$(cat "$CACHE_FILE")
THEME_DIR="$WALLPAPER_ROOT/$CURRENT_THEME"

# --- GENERATE REFRESH TILE ---
# Creates a 384x216 tile with "REFRESH" text if it doesn't exist
if [ ! -f "$REFRESH_THUMB" ]; then
    magick -size 384x216 xc:#1e1e2e \
        -gravity center -pointsize 48 -fill "#cba6f7" -annotate 0 "  Refresh" \
        "$REFRESH_THUMB"
fi

# 2. Logic to Generate Thumbnails
generate_thumbs() {
    notify-send -t 3000 "Wallpaper Menu" "Generating thumbnails for $CURRENT_THEME..."
    
    find "$THEME_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | while read -r file; do
        filename=$(basename "$file")
        thumb_path="$THUMB_DIR/${filename}.jpg"
        
        # Only generate if missing (Resolution: 384x216)
        if [ ! -f "$thumb_path" ]; then
            magick "$file" -resize 384x216^ -gravity center -extent 384x216 "$thumb_path"
        fi
    done
    
    notify-send -t 2000 "Wallpaper Menu" "Thumbnails Updated!"
}

# 3. Handle "Refresh" Argument
if [ "$1" == "refresh" ]; then
    generate_thumbs
    exec "$0"
    exit 0
fi

# 4. Prepare Rofi Input
ROFI_INPUT=""

# Add "REFRESH" Button using our custom tile
ROFI_INPUT+="Refresh Thumbnails\0icon\x1f$REFRESH_THUMB\n"

# Loop files
while IFS= read -r file; do
    filename=$(basename "$file")
    thumb_path="$THUMB_DIR/${filename}.jpg"
    
    if [ -f "$thumb_path" ]; then
        icon="$thumb_path"
    else
        icon="image-x-generic" 
    fi

    ROFI_INPUT+="$file\0icon\x1f$icon\n"
    
done < <(find "$THEME_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort)

# 5. Select Wallpaper (UPDATED COMMAND)
# Added -show-icons as requested
SELECTED=$(echo -en "$ROFI_INPUT" | rofi -dmenu -show-icons -theme "$ROFI_THEME" -p "Wallpaper")

[ -z "$SELECTED" ] && exit 0

# 6. Check Selection
if [[ "$SELECTED" == "Refresh Thumbnails" ]]; then
    "$0" refresh
    exit 0
fi

# 7. Apply Wallpaper
swww img "$SELECTED" --transition-type wipe --transition-fps 165 --transition-step 90
