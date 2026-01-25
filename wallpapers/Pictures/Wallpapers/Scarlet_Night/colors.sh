#!/bin/bash

# CUSTOM SCARLET NIGHT OVERRIDE
# High Contrast Edition: Fixes Rofi visibility issues.
# Palette: Deep Black (#050505) + Pure White (#FFFFFF) + Scarlet Red (#FF5555)

# --- PATHS ---
HYPR_CONF="$HOME/.config/hypr/colors.conf"
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
ROFI_CONF="$HOME/.config/rofi/colors.rasi"
BTOP_THEME="$HOME/.config/btop/themes/matugen.theme"
CAVA_CONF="$HOME/.config/cava/config"

# --- PALETTE VARIABLES ---
BG="#050505"
FG="#FFFFFF"            # Pure White for max contrast
ACCENT="#FF2A2A"        # Bright Scarlet Red
ACCENT_DIM="#AA0000"    # Darker Red for backgrounds
SURFACE="#101010"
SURFACE_DIM="#050505"

# ---------------------------------------------------------
# 1. HYPRLAND COLORS
# ---------------------------------------------------------
cat <<EOF > "$HYPR_CONF.tmp"
\$background = rgba(050505ff)
\$on_background = rgba(ffffffff)

\$surface = rgba(0a0a0aff)
\$surface_dim = rgba(050505ff)
\$surface_bright = rgba(1a1a1aff)

\$surface_container = rgba(141414ff)
\$surface_container_low = rgba(101010ff)
\$surface_container_high = rgba(202020ff)
\$surface_container_highest = rgba(2a2a2aff)
\$surface_container_lowest = rgba(000000ff)

\$on_surface = rgba(ffffffff)
\$on_surface_variant = rgba(ccccccff)

\$primary = rgba(ffffffff)
\$on_primary = rgba(000000ff)
\$primary_container = rgba(333333ff)
\$on_primary_container = rgba(ffffffff)
\$primary_fixed = rgba(e0e0e0ff)
\$primary_fixed_dim = rgba(c0c0c0ff)
\$on_primary_fixed = rgba(000000ff)

\$secondary = rgba(ccccccff)
\$on_secondary = rgba(000000ff)
\$secondary_container = rgba(222222ff)
\$on_secondary_container = rgba(ccccccff)
\$secondary_fixed = rgba(ccccccff)
\$secondary_fixed_dim = rgba(aaaaaaff)
\$on_secondary_fixed = rgba(000000ff)

\$tertiary = rgba(808080ff)
\$on_tertiary = rgba(ffffffff)
\$tertiary_container = rgba(111111ff)
\$on_tertiary_container = rgba(a0a0a0ff)

\$error = rgba(ff5555ff)
\$on_error = rgba(000000ff)
\$error_container = rgba(93000aff)
\$on_error_container = rgba(ffdad6ff)

\$outline = rgba(444444ff)
\$outline_variant = rgba(222222ff)
\$shadow = rgba(000000ff)
\$scrim = rgba(000000ff)
\$inverse_surface = rgba(ffffffff)
\$inverse_on_surface = rgba(000000ff)
\$inverse_primary = rgba(000000ff)
EOF

# ---------------------------------------------------------
# 2. KITTY THEME
# ---------------------------------------------------------
cat <<EOF > "$KITTY_CONF.tmp"
# Core Colors
background            $BG
foreground            $FG
cursor                $ACCENT
cursor_text_color     #000000
selection_background  $ACCENT_DIM
selection_foreground  #ffffff
url_color             $ACCENT

# Window borders
active_border_color   $ACCENT
inactive_border_color #333333
bell_border_color     $ACCENT

# Tab bar
active_tab_foreground   #000000
active_tab_background   $ACCENT
inactive_tab_foreground #888888
inactive_tab_background #0a0a0a

# Colors
color0  #101010
color8  #303030
color1  $ACCENT
color9  $ACCENT
color2  #a0a0a0
color10 #c0c0c0
color3  #808080
color11 #909090
color4  #cccccc
color12 #e0e0e0
color5  #bbbbbb
color13 #dddddd
color6  #eeeeee
color14 #ffffff
color7  #f0f0f0
color15 #ffffff
EOF

# ---------------------------------------------------------
# 3. ROFI THEME (colors.rasi) - HIGH CONTRAST FIX
# ---------------------------------------------------------
# Variables updated to ensure text is visible on dark backgrounds
cat <<EOF > "$ROFI_CONF.tmp"
* {
    background: $BG;
    on-background: $FG;
    
    surface: $SURFACE;
    surface-dim: $SURFACE_DIM;
    surface-bright: #202020;
    
    /* Primary Text (Selected/Important) -> RED */
    primary: $ACCENT;
    on-primary: #FFFFFF;
    primary-container: $ACCENT_DIM;
    on-primary-container: #FFFFFF;
    
    /* Secondary Text (List Items) -> WHITE (Was Grey) */
    secondary: #FFFFFF;
    on-secondary: #000000;
    secondary-container: #333333;
    on-secondary-container: #FFFFFF;
    
    /* Tertiary Text -> Bright Grey */
    tertiary: #CCCCCC;
    on-tertiary: #000000;
    tertiary-container: #EEEEEE;
    on-tertiary-container: #000000;
    
    error: $ACCENT;
    on-error: #000000;
    error-container: $ACCENT_DIM;
    on-error-container: #FFFFFF;
    
    /* Surface Text (Normal Text) -> Pure White */
    on-surface: #FFFFFF;
    on-surface-variant: #CCCCCC; 
    
    outline: #666666;
    outline-variant: #333333;
    shadow: #000000;
    scrim: #000000;
    
    inverse-surface: #FFFFFF;
    inverse-on-surface: #000000;
    inverse-primary: $ACCENT;
}
EOF

# ---------------------------------------------------------
# 4. BTOP THEME
# ---------------------------------------------------------
cat <<EOF > "$BTOP_THEME.tmp"
# Custom Scarlet Night Theme
theme[main_bg]="$BG"
theme[main_fg]="$FG"
theme[title]="$ACCENT"
theme[hi_fg]="$ACCENT"
theme[selected_bg]="$ACCENT_DIM"
theme[selected_fg]="#ffffff"
theme[inactive_fg]="#606060"
theme[graph_text]="$FG"
theme[meter_bg]="#202020"
theme[proc_misc]="$FG"
theme[cpu_box]="$ACCENT_DIM"
theme[mem_box]="$ACCENT_DIM"
theme[net_box]="$ACCENT_DIM"
theme[proc_box]="$ACCENT_DIM"
theme[div_line]="#303030"
theme[temp_start]="#303030"
theme[temp_mid]="$ACCENT_DIM"
theme[temp_end]="$ACCENT"
theme[cpu_start]="#303030"
theme[cpu_mid]="$ACCENT_DIM"
theme[cpu_end]="$ACCENT"
theme[free_start]="#303030"
theme[free_mid]="$ACCENT_DIM"
theme[free_end]="$ACCENT"
theme[cached_start]="#303030"
theme[cached_mid]="$ACCENT_DIM"
theme[cached_end]="$ACCENT"
theme[available_start]="#303030"
theme[available_mid]="$ACCENT_DIM"
theme[available_end]="$ACCENT"
theme[used_start]="#303030"
theme[used_mid]="$ACCENT_DIM"
theme[used_end]="$ACCENT"
theme[download_start]="#303030"
theme[download_mid]="$ACCENT_DIM"
theme[download_end]="$ACCENT"
theme[upload_start]="#303030"
theme[upload_mid]="$ACCENT_DIM"
theme[upload_end]="$ACCENT"
EOF

# ---------------------------------------------------------
# 5. CAVA CONFIG
# ---------------------------------------------------------
cat <<EOF > "$CAVA_CONF.tmp"
[color]
gradient = 1
gradient_count = 6
# Scarlet Night Gradient (Dark Red -> Bright Red -> White)
gradient_color_1 = '#330000'
gradient_color_2 = '#550000'
gradient_color_3 = '#770000'
gradient_color_4 = '#aa0000'
gradient_color_5 = '$ACCENT'
gradient_color_6 = '#ffffff'

[general]
mode = scientific
framerate = 60
autosens = 1
sensitivity = 60

[input]
method = pulse

[output]
method = ncurses

[smoothing]
integral = 77
monstercat = 0
waves = 0
gravity = 100
ignore = 0

[eq]
1 = 1
2 = 1
3 = 1
4 = 1
5 = 1
EOF

# ---------------------------------------------------------
# 6. ATOMIC SWAP (APPLY CHANGES)
# ---------------------------------------------------------
mv "$HYPR_CONF.tmp" "$HYPR_CONF"
mv "$KITTY_CONF.tmp" "$KITTY_CONF"
mv "$ROFI_CONF.tmp" "$ROFI_CONF"
mv "$BTOP_THEME.tmp" "$BTOP_THEME"
mv "$CAVA_CONF.tmp" "$CAVA_CONF"

# Notify
notify-send "Theme" "Scarlet Night (High Contrast) Applied."

# Refresh Cava (if running)
pkill -USR1 cava
