#!/bin/bash

# -----------------------------------------------------------------------------
# THEME: One_Dark
# DESCRIPTION: Deep Void Blue, Cool Grey Text, Cyan & Red Accents.
# TYPE: Static Palette Injection (Deep Edition)
# -----------------------------------------------------------------------------

# --- PATHS ---
HYPR_CONF="$HOME/.config/hypr/colors.conf"
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
ROFI_CONF="$HOME/.config/rofi/colors.rasi"
BTOP_THEME="$HOME/.config/btop/themes/matugen.theme"
CAVA_CONF="$HOME/.config/cava/config"

# --- PALETTE VARIABLES (Raw Hex) ---
BG="#15171c"              # Deep Space
FG="#abb2bf"              # Cadet Grey
SURFACE="#21252b"         # Gutter Grey
SURFACE_HIGH="#5c6370"    # Comment Grey (Borders/Dim)

ACCENT_PRI="#56b6c2"      # Cyan
ACCENT_TXT="#15171c"      # Dark Base (Text on Cyan)
ACCENT_SEC="#e06c75"      # Coral Red

TEXT_DIM="#5c6370"        # Comment Grey
BORDER_COL="#5c6370"      # Comment Grey
ERROR_COL="#e06c75"       # Red

# ---------------------------------------------------------
# 1. HYPRLAND (colors.conf)
# ---------------------------------------------------------
cat <<EOF > "$HYPR_CONF.tmp"
# One_Dark Hyprland Palette

# Core
\$background = rgba(15171cff)
\$on_background = rgba(abb2bfff)

# Surfaces
\$surface = rgba(21252bff)
\$surface_dim = rgba(15171cff)
\$surface_container = rgba(21252bff)

# FIX: Define the variable causing the 'Red Bar' error
\$surface_container_high = rgba(5c6370ff)

# Accents (Cyan + Red Gradient)
\$primary = rgba(56b6c2ff)
\$secondary = rgba(e06c75ff)
\$inactive_border = rgba(5c6370ff)

# Text
\$on_surface = rgba(abb2bfff)
\$on_primary = rgba(15171cff)
EOF

# ---------------------------------------------------------
# 2. KITTY (current-theme.conf)
# ---------------------------------------------------------
cat <<EOF > "$KITTY_CONF.tmp"
# One_Dark Kitty Theme
background            $BG
foreground            $FG
cursor                $ACCENT_PRI
selection_background  #3e4451
selection_foreground  $FG
url_color             #61afef

active_border_color   $ACCENT_PRI
inactive_border_color $SURFACE_HIGH
active_tab_background $ACCENT_PRI
active_tab_foreground $ACCENT_TXT
inactive_tab_background $SURFACE
inactive_tab_foreground $FG

# ANSI Palette (One Dark Pro)
color0  #21252b
color8  #5c6370
color1  #e06c75
color9  #e06c75
color2  #98c379
color10 #98c379
color3  #e5c07b
color11 #e5c07b
color4  #61afef
color12 #61afef
color5  #c678dd
color13 #c678dd
color6  #56b6c2
color14 #56b6c2
color7  #abb2bf
color15 #ffffff
EOF

# ---------------------------------------------------------
# 3. ROFI (colors.rasi) - FLAT DEFINITIONS
# ---------------------------------------------------------
cat <<EOF > "$ROFI_CONF.tmp"
* {
    /* One_Dark Rofi Palette */

    /* Backgrounds */
    background:     $BG;
    surface:        $SURFACE;
    
    /* Text */
    on-background:  $FG;
    on-surface:     $FG;
    text-dim:       $TEXT_DIM;

    /* Primary Selection (Cyan Box / Dark Text) */
    primary:        $ACCENT_PRI;
    on-primary:     $ACCENT_TXT;
    
    /* Secondary (Red) */
    secondary:      $ACCENT_SEC;
    on-secondary:   $ACCENT_TXT;

    /* Status */
    active:         $ACCENT_PRI;
    selected:       $ACCENT_PRI;
    urgent:         $ERROR_COL;
    error:          $ERROR_COL;
    on-error:       $FG;

    /* Borders */
    border-col:     $BORDER_COL;
    separator:      $BORDER_COL;
}
EOF

# ---------------------------------------------------------
# 4. BTOP (matugen.theme)
# ---------------------------------------------------------
cat <<EOF > "$BTOP_THEME.tmp"
theme[main_bg]="$BG"
theme[main_fg]="$FG"
theme[title]="$ACCENT_PRI"
theme[hi_fg]="$ACCENT_PRI"
theme[selected_bg]="$ACCENT_PRI"
theme[selected_fg]="$ACCENT_TXT"
theme[inactive_fg]="$TEXT_DIM"
theme[graph_text]="#98c379"
theme[cpu_box]="$SURFACE"
theme[mem_box]="$SURFACE"
theme[net_box]="$SURFACE"
theme[proc_box]="$SURFACE"
theme[div_line]="$SURFACE_HIGH"
theme[cpu_start]="#61afef"
theme[cpu_end]="#e06c75"
theme[mem_start]="#61afef"
theme[mem_end]="#e06c75"
theme[net_start]="#61afef"
theme[net_end]="#e06c75"
theme[download_start]="#61afef"
theme[download_end]="#e06c75"
theme[upload_start]="#61afef"
theme[upload_end]="#e06c75"
EOF

# ---------------------------------------------------------
# 5. CAVA & APPLY
# ---------------------------------------------------------
cat <<EOF > "$CAVA_CONF.tmp"
[color]
gradient = 1
gradient_count = 6
# Cyan -> Blue -> Purple -> Red -> Orange -> Yellow
gradient_color_1 = '#56b6c2'
gradient_color_2 = '#61afef'
gradient_color_3 = '#c678dd'
gradient_color_4 = '#e06c75'
gradient_color_5 = '#e5c07b'
gradient_color_6 = '#98c379'

[general]
mode = scientific
framerate = 60
autosens = 1
sensitivity = 60
bars = 0
bar_width = 2
bar_spacing = 1
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
EOF

mv "$HYPR_CONF.tmp" "$HYPR_CONF"
mv "$KITTY_CONF.tmp" "$KITTY_CONF"
mv "$ROFI_CONF.tmp" "$ROFI_CONF"
mv "$BTOP_THEME.tmp" "$BTOP_THEME"
mv "$CAVA_CONF.tmp" "$CAVA_CONF"

pkill -USR1 cava || true
notify-send "Theme" "One Dark Applied."
