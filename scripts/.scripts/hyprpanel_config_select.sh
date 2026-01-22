#!/bin/bash

# Optimized HyprPanel config selector

CONFIGS_DIR="$HOME/.config/hyprpanel/configs"
ACTIVE_CONFIG="$HOME/.config/hyprpanel/config.json"
ROFI_THEME="$HOME/.config/rofi/hyprpanel-config-select.rasi"

# Get configs efficiently
mapfile -t CONFIGS < <(find "$CONFIGS_DIR" -type f -name "*.json" -printf '%f\n' | sed 's/\.json$//' | sort)

# Select config
SELECTED=$(printf "%s\n" "${CONFIGS[@]}" | rofi -dmenu -theme "$ROFI_THEME" -p "Bar Layout")
[ -z "$SELECTED" ] && exit 0

CONFIG_FILE="$CONFIGS_DIR/${SELECTED}.json"

# Fast selective merge (optimized jq)
jq --compact-output -s '
    .[0] * (.[1] | {
        "bar.layouts": .["bar.layouts"],
        "bar.workspaces.workspaces": .["bar.workspaces.workspaces"],
        "theme.bar.floating": .["theme.bar.floating"],
        "theme.bar.border_radius": .["theme.bar.border_radius"],
        "theme.bar.margin_top": .["theme.bar.margin_top"],
        "theme.bar.margin_sides": .["theme.bar.margin_sides"],
        "theme.bar.outer_spacing": .["theme.bar.outer_spacing"],
        "theme.bar.buttons.radius": .["theme.bar.buttons.radius"]
    })
' "$ACTIVE_CONFIG" "$CONFIG_FILE" > "${ACTIVE_CONFIG}.tmp" && 
mv "${ACTIVE_CONFIG}.tmp" "$ACTIVE_CONFIG"

# Reload HyprPanel
if hyprpanel -h 2>/dev/null | grep -q "reload"; then
    hyprpanel reload
else
    pkill hyprpanel; hyprpanel &
fi

notify-send "HyprPanel" "Layout applied" -t 1500
