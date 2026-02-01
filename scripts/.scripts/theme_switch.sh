#!/bin/bash

# Optimized theme switcher with "Live Inject", App Reloads, Memory & Custom Previews
# STRICT MODE: Requires colors.sh in theme/scripts folder.

WALLPAPER_ROOT="$HOME/Pictures/Wallpapers"
CACHE_FILE="$HOME/.cache/current_theme"
ROFI_THEME="$HOME/.config/rofi/theme-select.rasi"
STATE_DIR="$HOME/.cache/theme_state"

# Ensure swww daemon is running
pgrep -x swww-daemon >/dev/null || { swww-daemon & sleep 0.5; }

# Build theme list
mapfile -t themes < <(find -L "$WALLPAPER_ROOT" -mindepth 1 -maxdepth 1 -type d -printf '%P\n' | sort)

# Build rofi input
ROFI_INPUT=""
for theme in "${themes[@]}"; do
    cover_image=""
    
    # 1. PRIORITY: Check for 'preview.*' in Theme Root (Case insensitive)
    cover_image=$(find "$WALLPAPER_ROOT/$theme" -maxdepth 1 -type f -iname "preview.*" -print -quit)
    
    # 2. SECONDARY: Check for 'preview.*' inside 'wallpapers/' folder
    if [ -z "$cover_image" ]; then
        cover_image=$(find "$WALLPAPER_ROOT/$theme/wallpapers" -maxdepth 1 -type f -iname "preview.*" -print -quit)
    fi

    # 3. FALLBACK: Pick the first wallpaper found if no preview exists
    if [ -z "$cover_image" ]; then
        cover_image=$(find "$WALLPAPER_ROOT/$theme/wallpapers" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) -print -quit)
    fi

    [ -n "$cover_image" ] && ROFI_INPUT+="$theme\0icon\x1f$cover_image\n"
done

# Show rofi
THEME_NAME=$(echo -en "$ROFI_INPUT" | rofi -dmenu -show-icons -theme "$ROFI_THEME" -p "Theme")
[ -z "$THEME_NAME" ] && exit 0

# Validate
[[ "$THEME_NAME" == *" "* ]] && { notify-send "Error" "Theme folder cannot contain spaces."; exit 1; }

# Get details
THEME_DIR="$WALLPAPER_ROOT/$THEME_NAME"

notify-send "Theme" "Applying $THEME_NAME..."

# Update cache
echo "$THEME_NAME" > "$CACHE_FILE"

# --- SMART WALLPAPER SELECTION ---
# Check if we have a remembered wallpaper for this theme
LAST_WALL="$STATE_DIR/${THEME_NAME}.wall"

if [ -f "$LAST_WALL" ] && [ -f "$(cat "$LAST_WALL")" ]; then
    DEFAULT_WALL=$(cat "$LAST_WALL")
else
    # Fallback: Pick the first wallpaper found in the folder
    DEFAULT_WALL=$(find "$THEME_DIR/wallpapers" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -print -quit)
fi

# --- 1. GENERATE COLORS (STRICT) ---
COLOR_SCRIPT="$THEME_DIR/scripts/colors.sh"
if [ -x "$COLOR_SCRIPT" ]; then
    "$COLOR_SCRIPT" "$DEFAULT_WALL"
else
    notify-send "Error" "colors.sh not found in $THEME_NAME/scripts/!"
    exit 1
fi

# --- 2. VS CODE INJECT ---
VSCODE_SETTINGS="$HOME/.config/Code/User/settings.json"
THEME_JSON="$THEME_DIR/apps/vscode.json"

if [ -f "$VSCODE_SETTINGS" ] && [ -f "$THEME_JSON" ]; then
    clean_json() {
        tr -d '\r' < "$1" | sed -E 's|^[[:space:]]*//.*||g' | sed -E 's|([[:space:]])//.*|\1|g' | sed -z 's/,\s*}/}/g; s/,\s*]/]/g'
    }

    if clean_json "$THEME_JSON" | jq '.' >/dev/null 2>&1; then
        TEMP_SETTINGS=$(mktemp)
        jq -s '
            .[0] as $settings | .[1] as $theme |
            $settings + {
                "workbench.colorCustomizations": ($theme.colors // {}),
                "editor.tokenColorCustomizations": { "textMateRules": ($theme.tokenColors // []) },
                "editor.semanticTokenColorCustomizations": (if ($theme.semanticTokenColors != null) then { "enabled": true, "rules": $theme.semanticTokenColors } else null end)
            } | del(.editor.semanticTokenColorCustomizations | select(. == null))
        ' <(clean_json "$VSCODE_SETTINGS") <(clean_json "$THEME_JSON") > "$TEMP_SETTINGS"

        [ -s "$TEMP_SETTINGS" ] && mv "$TEMP_SETTINGS" "$VSCODE_SETTINGS"
        rm -f "$TEMP_SETTINGS"
    fi
fi

# --- 3. RELOAD APPLICATIONS ---

# Apply Hyprpanel theme
TARGET_THEME_CONFIG="$THEME_DIR/hyprpanel/hyprpanel.json"
[ -f "$TARGET_THEME_CONFIG" ] && hyprpanel useTheme "$TARGET_THEME_CONFIG" &

# Update btop config and signal reload
BTOP_CONF="$HOME/.config/btop/btop.conf"
if [ -f "$BTOP_CONF" ]; then
    sed -i "s/^color_theme = .*/color_theme = \"matugen\"/" "$BTOP_CONF"
    pkill -USR2 btop
fi

# Reload Kitty
pkill -USR1 kitty

# Reload Cava
pkill -USR1 cava

pkill -USR1 nvim

# Apply Wallpaper
swww img "$DEFAULT_WALL" --transition-type any --transition-fps 60 --transition-step 25 --transition-duration 3 &

wait
