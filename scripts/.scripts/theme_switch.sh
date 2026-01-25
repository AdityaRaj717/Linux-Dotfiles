#!/bin/bash

# Optimized theme switcher with VS Code "Live Inject"
# Dependencies: rofi, swww, jq, sed, matugen (optional)

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

# --- SYSTEM COLORS (Kitty/Matugen) ---
if [ -x "$THEME_DIR/colors.sh" ]; then
    "$THEME_DIR/colors.sh" "$DEFAULT_WALL"
else
    if command -v matugen &> /dev/null; then
        matugen image "$DEFAULT_WALL" >/dev/null 2>&1
        cp "$HOME/.config/kitty/themes/Matugen.conf" "$HOME/.config/kitty/current-theme.conf"
    fi
fi

# --- VS CODE LIVE INJECT ---
VSCODE_SETTINGS="$HOME/.config/Code/User/settings.json"
THEME_JSON="$THEME_DIR/vscode.json"

if [ ! -f "$VSCODE_SETTINGS" ]; then
    notify-send "Error" "VS Code settings not found."
elif [ ! -f "$THEME_JSON" ]; then
    notify-send "Warning" "No vscode.json found in $THEME_NAME folder."
else
    # 2. Define Cleaner Function (URL-Safe & Trailing Comma Remover)
    clean_json() {
        # 1. Remove CRLF (\r) for Windows compatibility
        # 2. Remove full-line comments (start with whitespace + //)
        # 3. Remove inline comments (space + //), preserving URLs like http://
        # 4. Remove trailing commas (using -z for multiline)
        tr -d '\r' < "$1" | \
        sed -E 's|^[[:space:]]*//.*||g' | \
        sed -E 's|([[:space:]])//.*|\1|g' | \
        sed -z 's/,\s*}/}/g; s/,\s*]/]/g'
    }

    # 3. Validation Step
    # We parse the cleaned theme first to catch syntax errors early
    THEME_ERRORS=$(clean_json "$THEME_JSON" | jq '.' 2>&1 >/dev/null)
    
    if [ $? -ne 0 ]; then
        SHORT_ERR=$(echo "$THEME_ERRORS" | head -n 1)
        notify-send "Theme Error" "Invalid JSON in $THEME_NAME: $SHORT_ERR"
        exit 1
    fi

    notify-send "VS Code" "Injecting theme colors..."

    # 4. Safe Merge
    TEMP_SETTINGS=$(mktemp)

    jq -s '
        .[0] as $settings | .[1] as $theme |
        $settings + {
            "workbench.colorCustomizations": ($theme.colors // {}),
            "editor.tokenColorCustomizations": {
                "textMateRules": ($theme.tokenColors // [])
            },
            "editor.semanticTokenColorCustomizations": (
                if ($theme.semanticTokenColors != null) then
                    {
                        "enabled": true,
                        "rules": $theme.semanticTokenColors
                    }
                else
                    null
                end
            )
        } | del(.editor.semanticTokenColorCustomizations | select(. == null))
    ' <(clean_json "$VSCODE_SETTINGS") <(clean_json "$THEME_JSON") > "$TEMP_SETTINGS"

    # 5. Apply
    if [ -s "$TEMP_SETTINGS" ]; then
        mv "$TEMP_SETTINGS" "$VSCODE_SETTINGS"
        notify-send "VS Code" "Theme updated to $THEME_NAME"
    else
        notify-send "Error" "Failed to merge settings. Check syntax."
    fi
    rm -f "$TEMP_SETTINGS"
fi

TARGET_THEME_CONFIG="$THEME_DIR/hyprpanel.json"
[ -f "$TARGET_THEME_CONFIG" ] && hyprpanel useTheme "$TARGET_THEME_CONFIG" &

pkill -USR1 kitty
hyprctl reload &
swww img "$DEFAULT_WALL" --transition-type grow --transition-fps 60 --transition-step 90 &

wait
