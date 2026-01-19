#!/bin/bash

# --- CONFIG ---
CONFIGS_DIR="$HOME/.config/hyprpanel/configs"
ACTIVE_CONFIG="$HOME/.config/hyprpanel/config.json"
ROFI_THEME="$HOME/.config/rofi/hyprpanel-config-select.rasi"

# 1. Select Config
mapfile -t CONFIGS < <(find "$CONFIGS_DIR" -type f -name "*.json" -printf '%f\n' | sort)
ROFI_INPUT=$(printf "%s\n" "${CONFIGS[@]%.*}")
SELECTED=$(echo -e "$ROFI_INPUT" | rofi -dmenu -theme "$ROFI_THEME" -p "Bar Layout")
[ -z "$SELECTED" ] && exit 0

CONFIG_FILE="$CONFIGS_DIR/${SELECTED}.json"

# 2. FAST SELECTIVE MERGE
# We target only 'bar' and 'menus' for layout, while keeping ALL other keys (Colors/Wallpaper)
# This is significantly faster than a recursive tree search.
jq -s '.[0] * (.[1] | {
    "bar.layouts": .["bar.layouts"],
    "bar.workspaces.workspaces": .["bar.workspaces.workspaces"],
    "theme.bar.floating": .["theme.bar.floating"],
    "theme.bar.border_radius": .["theme.bar.border_radius"],
    "theme.bar.margin_top": .["theme.bar.margin_top"],
    "theme.bar.margin_sides": .["theme.bar.margin_sides"],
    "theme.bar.outer_spacing": .["theme.bar.outer_spacing"],
    "theme.bar.buttons.radius": .["theme.bar.buttons.radius"]
})' "$ACTIVE_CONFIG" "$CONFIG_FILE" > "${ACTIVE_CONFIG}.tmp" && mv "${ACTIVE_CONFIG}.tmp" "$ACTIVE_CONFIG"

# 3. RELOAD WITHOUT KILLING (If possible)
# Most 2026 versions of HyprPanel support a reload signal. 
# If 'hyprpanel reload' is not supported by your version, use the fast restart below.
if hyprpanel -h | grep -q "reload"; then
    hyprpanel reload
    notify-send -t 1000 "HyprPanel" "Layout Refreshed"
else
    # Fast background restart to minimize wallpaper flicker
    (pkill hyprpanel; sleep 0.1; hyprpanel) &
    notify-send -t 1000 "HyprPanel" "Layout Swapped"
fi

