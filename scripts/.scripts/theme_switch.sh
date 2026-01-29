#!/bin/bash

# Optimized theme switcher with "Live Inject" & App Reloads
# Fixes: Race Condition (Red Bar), Cava Reload, Btop (via SIGUSR2)

WALLPAPER_ROOT="$HOME/Pictures/Wallpapers"
CACHE_FILE="$HOME/.cache/current_theme"
ROFI_THEME="$HOME/.config/rofi/theme-select.rasi"

# Ensure swww daemon is running
pgrep -x swww-daemon >/dev/null || { swww-daemon & sleep 0.5; }

# Build theme list
mapfile -t themes < <(find -L "$WALLPAPER_ROOT" -mindepth 1 -maxdepth 1 -type d -printf '%P\n' | sort)

# Build rofi input
ROFI_INPUT=""
for theme in "${themes[@]}"; do
    cover_image=$(find "$WALLPAPER_ROOT/$theme" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -print -quit)
    [ -n "$cover_image" ] && ROFI_INPUT+="$theme\0icon\x1f$cover_image\n"
done

# Show rofi
THEME_NAME=$(echo -en "$ROFI_INPUT" | rofi -dmenu -show-icons -theme "$ROFI_THEME" -p "Theme")
[ -z "$THEME_NAME" ] && exit 0

# Validate
[[ "$THEME_NAME" == *" "* ]] && { notify-send "Error" "Theme folder cannot contain spaces."; exit 1; }

# Get details
THEME_DIR="$WALLPAPER_ROOT/$THEME_NAME"
DEFAULT_WALL=$(find "$THEME_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -print -quit)

notify-send "Theme" "Applying $THEME_NAME..."

# Update cache
echo "$THEME_NAME" > "$CACHE_FILE"

# --- 1. GENERATE COLORS ---
if [ -x "$THEME_DIR/colors.sh" ]; then
    "$THEME_DIR/colors.sh" "$DEFAULT_WALL"
else
    if command -v matugen &> /dev/null; then
        matugen image "$DEFAULT_WALL" >/dev/null 2>&1
        cp "$HOME/.config/kitty/themes/Matugen.conf" "$HOME/.config/kitty/current-theme.conf"
    fi
fi

# --- 2. VS CODE INJECT ---
VSCODE_SETTINGS="$HOME/.config/Code/User/settings.json"
THEME_JSON="$THEME_DIR/vscode.json"

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
TARGET_THEME_CONFIG="$THEME_DIR/hyprpanel.json"
[ -f "$TARGET_THEME_CONFIG" ] && hyprpanel useTheme "$TARGET_THEME_CONFIG" &

# Update btop config and signal reload
# Note: Ensure the theme name matches the .theme file name in ~/.config/btop/themes/
BTOP_CONF="$HOME/.config/btop/btop.conf"
if [ -f "$BTOP_CONF" ]; then
    # We update the config file first so btop reads the new theme on signal
    sed -i "s/^color_theme = .*/color_theme = \"matugen\"/" "$BTOP_CONF"
    pkill -USR2 btop
fi

# Reload Kitty
pkill -USR1 kitty

# Reload Cava
pkill -USR1 cava

# Apply Wallpaper
swww img "$DEFAULT_WALL" --transition-type grow --transition-fps 60 --transition-step 90 &

wait

