#!/bin/bash

CURRENT_WALL=$(swww query | grep "image: " | awk -F 'image: ' '{print $2}')
[ -z "$CURRENT_WALL" ] && exit 1

# Generate colors
matugen image "$CURRENT_WALL"

# Update applications
sync
sleep 0.5

# Kitty
cp "$HOME/.config/kitty/themes/Matugen.conf" "$HOME/.config/kitty/current-theme.conf"
pkill -USR1 kitty

# Hyprland
hyprctl reload

notify-send "System" "Colors regenerated."
