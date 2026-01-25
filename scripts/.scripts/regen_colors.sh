#!/bin/bash

# Optimized color regeneration with VS Code force reload

CACHE_FILE="$HOME/.cache/current_theme"
WALLPAPER_ROOT="$HOME/Pictures/Wallpapers"

# Get current wallpaper (fail fast)
CURRENT_WALL=$(swww query 2>/dev/null | awk -F 'image: ' '/image:/ {print $2}')
[ -z "$CURRENT_WALL" ] && exit 1

# Resolve theme directory
if [ -f "$CACHE_FILE" ]; then
    CURRENT_THEME=$(cat "$CACHE_FILE")
    THEME_DIR="$WALLPAPER_ROOT/$CURRENT_THEME"
else
    THEME_DIR=""
fi

# Generate colors
{
    if [ -n "$THEME_DIR" ] && [ -x "$THEME_DIR/colors.sh" ]; then
        "$THEME_DIR/colors.sh" "$CURRENT_WALL"
    else
        matugen image "$CURRENT_WALL" >/dev/null 2>&1
        cp "$HOME/.config/kitty/themes/Matugen.conf" "$HOME/.config/kitty/current-theme.conf"
    fi

    # --- VS CODE FORCE RELOAD METHOD ---
    VSCODE_EXT=$(find ~/.vscode/extensions -type d -name "*my-dynamic-theme*" -print -quit 2>/dev/null)
    if [ -n "$VSCODE_EXT" ] && [ -n "$THEME_DIR" ]; then
        VSCODE_TARGET="$VSCODE_EXT/themes/theme.json"
        MANUAL_THEME="$THEME_DIR/vscode.json"
        
        if [ -f "$MANUAL_THEME" ]; then
            # Copy the theme
            cp "$MANUAL_THEME" "$VSCODE_TARGET" 2>/dev/null
            
            # Force reload by touching package.json
            touch "$VSCODE_EXT/package.json"
        fi
    fi

    # Reload apps
    pkill -USR1 kitty
    
} &

hyprctl reload &

wait

notify-send "System" "Colors regenerated." -t 1500
