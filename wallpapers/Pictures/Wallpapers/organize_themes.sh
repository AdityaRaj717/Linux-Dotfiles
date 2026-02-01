#!/bin/bash

# Define the root directory
WALLPAPER_ROOT="$HOME/Pictures/Wallpapers"

echo "Starting organization of all themes in $WALLPAPER_ROOT..."

# Loop through each directory in the Wallpapers folder
for theme_path in "$WALLPAPER_ROOT"/*/; do
    # Remove trailing slash
    theme_path=${theme_path%*/}
    theme_name=$(basename "$theme_path")

    # Skip if it's not a directory
    [ ! -d "$theme_path" ] && continue

    echo "Processing: $theme_name"

    # 1. Create the standard subdirectories
    mkdir -p "$theme_path/wallpapers"
    mkdir -p "$theme_path/hyprpanel"
    mkdir -p "$theme_path/apps"
    mkdir -p "$theme_path/scripts"

    # 2. Move App Configs FIRST
    # We move vscode.json first so it doesn't get grabbed by the *.json wildcard later
    mv "$theme_path"/vscode.json "$theme_path/apps/" 2>/dev/null
    mv "$theme_path"/neovim.lua "$theme_path/apps/" 2>/dev/null

    # 3. Move Scripts
    mv "$theme_path"/*.sh "$theme_path"/*.py "$theme_path/scripts/" 2>/dev/null
    # Ensure scripts are executable
    chmod +x "$theme_path/scripts/"*.sh 2>/dev/null

    # 4. Move Wallpapers
    mv "$theme_path"/*.png "$theme_path"/*.jpg "$theme_path"/*.jpeg "$theme_path"/*.webp "$theme_path"/*.gif "$theme_path/wallpapers/" 2>/dev/null

    # 5. Move HyprPanel Configs
    # Any remaining .json files are assumed to be HyprPanel themes
    mv "$theme_path"/*.json "$theme_path/hyprpanel/" 2>/dev/null

    # Optional: Remove empty folders if you want (commented out for safety)
    # rmdir "$theme_path/wallpapers" "$theme_path/hyprpanel" "$theme_path/apps" "$theme_path/scripts" --ignore-fail-on-non-empty 2>/dev/null
done

echo "✅ All themes organized successfully!"
notify-send "System" "All theme folders have been organized."
