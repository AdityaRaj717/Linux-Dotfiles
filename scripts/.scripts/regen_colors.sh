#!/bin/bash

# Optimized color regeneration with parallel updates

# Get current wallpaper (fail fast)
CURRENT_WALL=$(swww query 2>/dev/null | awk -F 'image: ' '/image:/ {print $2}')
[ -z "$CURRENT_WALL" ] && exit 1

# Generate colors
matugen image "$CURRENT_WALL" >/dev/null 2>&1 || exit 1

# Update applications in parallel
{
    cp "$HOME/.config/kitty/themes/Matugen.conf" "$HOME/.config/kitty/current-theme.conf"
    pkill -USR1 kitty
} &

hyprctl reload &

wait

notify-send "System" "Colors regenerated." -t 1500
