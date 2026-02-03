#!/bin/bash

# -----------------------------------------------------------------------------
# THEME: Green_Lush
# DESCRIPTION: Deep Organic Black, Sage, and Matcha. (Botanical Matte)
# TYPE: Static Palette Injection
# -----------------------------------------------------------------------------

# --- PATHS ---
HYPR_CONF="$HOME/.config/hypr/colors.conf"
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
ROFI_CONF="$HOME/.config/rofi/colors.rasi"
BTOP_THEME="$HOME/.config/btop/themes/matugen.theme"
CAVA_CONF="$HOME/.config/cava/config"

# --- PALETTE VARIABLES (Raw Hex) ---
BG="#0a0f0d"              # Deep Jungle
FG="#e0e6e2"              # Mist White
SURFACE="#18211b"         # Dark Moss
SURFACE_HIGH="#3d4f43"    # Shadowed Leaf (Borders/Dim)

ACCENT_PRI="#7cac8a"      # Sage Green (Matte)
ACCENT_TXT="#0a0f0d"      # Deep Jungle (Dark Text on Sage)
ACCENT_SEC="#a3c9a8"      # Matcha

TEXT_DIM="#3d4f43"        # Shadowed Leaf
BORDER_COL="#3d4f43"      # Shadowed Leaf
ERROR_COL="#d48c8c"       # Muted Rose

# ---------------------------------------------------------
# 1. HYPRLAND (colors.conf)
# ---------------------------------------------------------
cat <<EOF > "$HYPR_CONF.tmp"
# Green_Lush Hyprland Palette

# Core
\$background = rgba(0a0f0dff)
\$on_background = rgba(e0e6e2ff)

# Surfaces
\$surface = rgba(18211bff)
\$surface_dim = rgba(0a0f0dff)
\$surface_container = rgba(18211bff)

# FIX: Define the variable causing the 'Red Bar' error
\$surface_container_high = rgba(3d4f43ff)

# Accents (Sage + Matcha Gradient)
\$primary = rgba(7cac8aff)
\$secondary = rgba(a3c9a8ff)
\$inactive_border = rgba(3d4f43ff)

# Text
\$on_surface = rgba(e0e6e2ff)
\$on_primary = rgba(0a0f0dff)
EOF

# ---------------------------------------------------------
# 2. KITTY (current-theme.conf)
# ---------------------------------------------------------
cat <<EOF > "$KITTY_CONF.tmp"
# Green_Lush Kitty Theme
background            $BG
foreground            $FG
cursor                $ACCENT_PRI
selection_background  $SURFACE_HIGH
selection_foreground  $FG
url_color             $ACCENT_PRI

active_border_color   $ACCENT_PRI
inactive_border_color $SURFACE_HIGH
active_tab_background $ACCENT_PRI
active_tab_foreground $ACCENT_TXT
inactive_tab_background $SURFACE
inactive_tab_foreground $FG

# ANSI Palette (The Greenhouse Spectrum)
color0  #18211b
color8  #3d4f43
color1  #d48c8c
color9  #e0a3a3
color2  #7cac8a
color10 #a3c9a8
color3  #d9d096
color11 #e6dfb8
color4  #8ca0b0
color12 #aabccf
color5  #b08ca6
color13 #cfabc5
color6  #89b8a8
color14 #a8d1c4
color7  #c5cfc9
color15 #e0e6e2
EOF

# ---------------------------------------------------------
# 3. ROFI (colors.rasi) - FLAT DEFINITIONS
# ---------------------------------------------------------
cat <<EOF > "$ROFI_CONF.tmp"
* {
    /* Green_Lush Rofi Palette */

    /* Backgrounds */
    background:     $BG;
    surface:        $SURFACE;
    
    /* Text */
    on-background:  $FG;
    on-surface:     $FG;
    text-dim:       $TEXT_DIM;

    /* Primary Selection (Sage Box / Dark Text) */
    primary:        $ACCENT_PRI;
    on-primary:     $ACCENT_TXT;
    
    /* Secondary (Matcha) */
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
theme[graph_text]="$ACCENT_SEC"
theme[cpu_box]="$SURFACE"
theme[mem_box]="$SURFACE"
theme[net_box]="$SURFACE"
theme[proc_box]="$SURFACE"
theme[div_line]="$SURFACE_HIGH"
theme[cpu_start]="$ACCENT_PRI"
theme[cpu_end]="$ACCENT_SEC"
theme[mem_start]="$ACCENT_PRI"
theme[mem_end]="$ACCENT_SEC"
theme[net_start]="$ACCENT_PRI"
theme[net_end]="$ACCENT_SEC"
theme[download_start]="$ACCENT_PRI"
theme[download_end]="$ACCENT_SEC"
theme[upload_start]="$ACCENT_PRI"
theme[upload_end]="$ACCENT_SEC"
EOF

# ---------------------------------------------------------
# 5. CAVA & APPLY
# ---------------------------------------------------------
cat <<EOF > "$CAVA_CONF.tmp"
[color]
gradient = 1
gradient_count = 6
# Forest -> Sage -> Matcha -> Pale Leaf
gradient_color_1 = '#3d4f43'
gradient_color_2 = '#5c8065'
gradient_color_3 = '#7cac8a'
gradient_color_4 = '#8fb59b'
gradient_color_5 = '#a3c9a8'
gradient_color_6 = '#c5cfc9'

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
