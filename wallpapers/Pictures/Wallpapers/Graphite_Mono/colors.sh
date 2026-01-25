#!/bin/bash

# CUSTOM GRAPHITE MONO OVERRIDE
# "All-in-One" script: Updates Hyprland, Kitty, Rofi, Btop, and Cava.
# Palette: Strictly Grayscale (Black #050505, White #FFFFFF, Gray Accents)
# Uses ATOMIC WRITES to prevent config errors.

# --- PATHS ---
HYPR_CONF="$HOME/.config/hypr/colors.conf"
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
ROFI_CONF="$HOME/.config/rofi/colors.rasi"
BTOP_THEME="$HOME/.config/btop/themes/matugen.theme"
CAVA_CONF="$HOME/.config/cava/config"

# --- PALETTE VARIABLES ---
BG="#050505"
FG="#eeeeee"
ACCENT="#ffffff"        # Pure White
ACCENT_DIM="#404040"    # Dark Gray for selections
SURFACE="#101010"

# ---------------------------------------------------------
# 1. HYPRLAND COLORS (Strictly Mono)
# ---------------------------------------------------------
cat <<EOF > "$HYPR_CONF.tmp"
# -- Core Colors --
\$background = rgba(050505ff)
\$on_background = rgba(eeeeeeff)

# -- Surfaces --
\$surface = rgba(0a0a0aff)
\$surface_dim = rgba(050505ff)
\$surface_bright = rgba(1a1a1aff)

# -- Containers --
\$surface_container = rgba(141414ff)
\$surface_container_low = rgba(101010ff)
\$surface_container_high = rgba(202020ff)
\$surface_container_highest = rgba(2a2a2aff)
\$surface_container_lowest = rgba(000000ff)

\$on_surface = rgba(eeeeeeff)
\$on_surface_variant = rgba(a0a0a0ff)

# -- Primary (White) --
\$primary = rgba(ffffffff)
\$on_primary = rgba(000000ff)
\$primary_container = rgba(333333ff)
\$on_primary_container = rgba(ffffffff)
\$primary_fixed = rgba(e0e0e0ff)
\$primary_fixed_dim = rgba(c0c0c0ff)
\$on_primary_fixed = rgba(000000ff)

# -- Secondary (Gray) --
\$secondary = rgba(ccccccff)
\$on_secondary = rgba(000000ff)
\$secondary_container = rgba(222222ff)
\$on_secondary_container = rgba(ccccccff)
\$secondary_fixed = rgba(ccccccff)
\$secondary_fixed_dim = rgba(aaaaaaff)
\$on_secondary_fixed = rgba(000000ff)

# -- Tertiary (Dark Gray) --
\$tertiary = rgba(808080ff)
\$on_tertiary = rgba(ffffffff)
\$tertiary_container = rgba(111111ff)
\$on_tertiary_container = rgba(a0a0a0ff)

# -- Errors (Grayscale - No Red) --
\$error = rgba(ffffffff)
\$on_error = rgba(000000ff)
\$error_container = rgba(404040ff)
\$on_error_container = rgba(ffffffff)

# -- Misc --
\$outline = rgba(444444ff)
\$outline_variant = rgba(222222ff)
\$shadow = rgba(000000ff)
\$scrim = rgba(000000ff)
\$inverse_surface = rgba(eeeeeeff)
\$inverse_on_surface = rgba(000000ff)
\$inverse_primary = rgba(000000ff)
EOF

# ---------------------------------------------------------
# 2. KITTY THEME (Strictly Mono)
# ---------------------------------------------------------
cat <<EOF > "$KITTY_CONF.tmp"
# Core Colors
background            $BG
foreground            $FG
cursor                $ACCENT
cursor_text_color     #000000
selection_background  $ACCENT_DIM
selection_foreground  #ffffff
url_color             #cccccc

# Window borders
active_border_color   $ACCENT
inactive_border_color #333333
bell_border_color     #808080

# Tab bar
active_tab_foreground   #000000
active_tab_background   $ACCENT
inactive_tab_foreground #888888
inactive_tab_background #0a0a0a

# --- TERMINAL PALETTE (Strictly Grayscale) ---
color0  #101010
color8  #303030
color1  #606060
color9  #808080
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
# 3. ROFI THEME (High Contrast Mono)
# ---------------------------------------------------------
cat <<EOF > "$ROFI_CONF.tmp"
* {
    background: $BG;
    on-background: $FG;
    surface: $SURFACE;
    surface-dim: #050505;
    surface-bright: #202020;
    
    /* Primary (Selected) -> WHITE */
    primary: $ACCENT;
    on-primary: #000000;
    primary-container: $ACCENT_DIM;
    on-primary-container: #ffffff;
    
    /* Secondary -> Light Gray */
    secondary: #cccccc;
    on-secondary: #000000;
    secondary-container: #333333;
    on-secondary-container: #ffffff;
    
    tertiary: #808080;
    on-tertiary: #ffffff;
    tertiary-container: #202020;
    on-tertiary-container: #cccccc;
    
    /* Errors -> White (No Red) */
    error: #ffffff;
    on-error: #000000;
    error-container: #404040;
    on-error-container: #ffffff;
    
    /* Text Visibility */
    on-surface: #ffffff;
    on-surface-variant: #cccccc;
    
    outline: #444444;
    outline-variant: #222222;
    shadow: #000000;
    scrim: #000000;
    
    inverse-surface: $FG;
    inverse-on-surface: $BG;
    inverse-primary: #000000;
}
EOF

# ---------------------------------------------------------
# 4. BTOP THEME (Mono)
# ---------------------------------------------------------
cat <<EOF > "$BTOP_THEME.tmp"
# Custom Graphite Mono Theme
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
# 5. CAVA CONFIG (Mono Gradient)
# ---------------------------------------------------------
cat <<EOF > "$CAVA_CONF.tmp"
[color]
gradient = 1
gradient_count = 6
# Monochrome Gradient (Dark Gray -> White)
gradient_color_1 = '#202020'
gradient_color_2 = '#404040'
gradient_color_3 = '#606060'
gradient_color_4 = '#808080'
gradient_color_5 = '#a0a0a0'
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
# 6. ATOMIC SWAP
# ---------------------------------------------------------
mv "$HYPR_CONF.tmp" "$HYPR_CONF"
mv "$KITTY_CONF.tmp" "$KITTY_CONF"
mv "$ROFI_CONF.tmp" "$ROFI_CONF"
mv "$BTOP_THEME.tmp" "$BTOP_THEME"
mv "$CAVA_CONF.tmp" "$CAVA_CONF"

# Notify
notify-send "Theme" "Graphite Mono (All Apps) Applied."

# Refresh Cava (if running)
pkill -USR1 cava
