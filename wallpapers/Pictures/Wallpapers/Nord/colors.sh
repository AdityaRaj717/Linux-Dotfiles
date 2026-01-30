#!/bin/bash

# -----------------------------------------------------------------------------
# THEME: Nord
# DESCRIPTION: Polar Night Blue, Snow Storm White, and Aurora Accents.
# TYPE: Static Palette Injection (Official Arctic Spec)
# -----------------------------------------------------------------------------

# --- PATHS ---
HYPR_CONF="$HOME/.config/hypr/colors.conf"
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
ROFI_CONF="$HOME/.config/rofi/colors.rasi"
BTOP_THEME="$HOME/.config/btop/themes/matugen.theme"
CAVA_CONF="$HOME/.config/cava/config"

# --- PALETTE VARIABLES (Raw Hex) ---
BG="#2e3440"              # Polar Night (Nord0)
FG="#eceff4"              # Snow Storm (Nord6)
SURFACE="#3b4252"         # Lighter Polar Night (Nord1)
SURFACE_HIGH="#4c566a"    # Muted Grey-Blue (Nord3 - Borders/Dim)

ACCENT_PRI="#88c0d0"      # Frozen Cyan (Nord8)
ACCENT_TXT="#2e3440"      # Dark Text (on Cyan)
ACCENT_SEC="#81a1c1"      # Glacial Blue (Nord9)

TEXT_DIM="#4c566a"        # Nord3
BORDER_COL="#4c566a"      # Nord3
ERROR_COL="#bf616a"       # Aurora Red

# ---------------------------------------------------------
# 1. HYPRLAND (colors.conf)
# ---------------------------------------------------------
cat <<EOF > "$HYPR_CONF.tmp"
# Nord Hyprland Palette

# Core
\$background = rgba(2e3440ff)
\$on_background = rgba(eceff4ff)

# Surfaces
\$surface = rgba(3b4252ff)
\$surface_dim = rgba(2e3440ff)
\$surface_container = rgba(3b4252ff)

# FIX: Define the variable causing the 'Red Bar' error
\$surface_container_high = rgba(4c566aff)

# Accents (Cyan + Deep Blue Gradient)
\$primary = rgba(88c0d0ff)
\$secondary = rgba(5e81acff)
\$inactive_border = rgba(4c566aff)

# Text
\$on_surface = rgba(eceff4ff)
\$on_primary = rgba(2e3440ff)
EOF

# ---------------------------------------------------------
# 2. KITTY (current-theme.conf)
# ---------------------------------------------------------
cat <<EOF > "$KITTY_CONF.tmp"
# Nord Kitty Theme
background            $BG
foreground            $FG
cursor                #88c0d0
selection_background  #4c566a
selection_foreground  #eceff4
url_color             #88c0d0

active_border_color   $ACCENT_PRI
inactive_border_color $SURFACE_HIGH
active_tab_background $ACCENT_PRI
active_tab_foreground $ACCENT_TXT
inactive_tab_background $SURFACE
inactive_tab_foreground $FG

# ANSI Palette (Official Nord Specs)
color0  #3b4252
color8  #4c566a
color1  #bf616a
color9  #bf616a
color2  #a3be8c
color10 #a3be8c
color3  #ebcb8b
color11 #ebcb8b
color4  #81a1c1
color12 #81a1c1
color5  #b48ead
color13 #b48ead
color6  #88c0d0
color14 #8fbcbb
color7  #e5e9f0
color15 #eceff4
EOF

# ---------------------------------------------------------
# 3. ROFI (colors.rasi) - FLAT DEFINITIONS
# ---------------------------------------------------------
cat <<EOF > "$ROFI_CONF.tmp"
* {
    /* Nord Rofi Palette */

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
    
    /* Secondary (Glacial Blue) */
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
theme[graph_text]="#81a1c1"
theme[cpu_box]="$SURFACE"
theme[mem_box]="$SURFACE"
theme[net_box]="$SURFACE"
theme[proc_box]="$SURFACE"
theme[div_line]="$SURFACE_HIGH"
theme[cpu_start]="#a3be8c"
theme[cpu_end]="#bf616a"
theme[mem_start]="#a3be8c"
theme[mem_end]="#bf616a"
theme[net_start]="#a3be8c"
theme[net_end]="#bf616a"
theme[download_start]="#a3be8c"
theme[download_end]="#bf616a"
theme[upload_start]="#a3be8c"
theme[upload_end]="#bf616a"
EOF

# ---------------------------------------------------------
# 5. CAVA & APPLY
# ---------------------------------------------------------
cat <<EOF > "$CAVA_CONF.tmp"
[color]
gradient = 1
gradient_count = 6
# Blue -> Cyan -> Green -> Yellow -> Orange -> Red
gradient_color_1 = '#5e81ac'
gradient_color_2 = '#81a1c1'
gradient_color_3 = '#88c0d0'
gradient_color_4 = '#a3be8c'
gradient_color_5 = '#ebcb8b'
gradient_color_6 = '#bf616a'

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
notify-send "Theme" "Nord Applied."
