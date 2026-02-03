#!/bin/bash

# -----------------------------------------------------------------------------
# THEME: Scarlet_Night
# DESCRIPTION: Wet Asphalt, Carbon Grey, and Matte Corsa Red. (F1 Aesthetic)
# TYPE: Static Palette Injection (Matte Dark Mode)
# -----------------------------------------------------------------------------

# --- PATHS ---
HYPR_CONF="$HOME/.config/hypr/colors.conf"
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
ROFI_CONF="$HOME/.config/rofi/colors.rasi"
BTOP_THEME="$HOME/.config/btop/themes/matugen.theme"
CAVA_CONF="$HOME/.config/cava/config"

# --- PALETTE VARIABLES (Raw Hex) ---
BG="#121214"              # Wet Asphalt
FG="#e5e5ea"              # Platinum White
SURFACE="#27272a"         # Carbon Grey
SURFACE_HIGH="#3f3f46"    # Dark Steel (Borders/Dim)

ACCENT_PRI="#d63a4a"      # Matte Corsa Red
ACCENT_TXT="#ffffff"      # White (High contrast on Red)
ACCENT_SEC="#9e9ea0"      # Steel Grey

TEXT_DIM="#3f3f46"        # Dark Steel
BORDER_COL="#3f3f46"      # Dark Steel
ERROR_COL="#d63a4a"       # Red

# ---------------------------------------------------------
# 1. HYPRLAND (colors.conf)
# ---------------------------------------------------------
cat <<EOF > "$HYPR_CONF.tmp"
# Scarlet_Night Hyprland Palette

# Core
\$background = rgba(121214ff)
\$on_background = rgba(e5e5eaff)

# Surfaces
\$surface = rgba(27272aff)
\$surface_dim = rgba(121214ff)
\$surface_container = rgba(27272aff)

# FIX: Define the variable causing the 'Red Bar' error
\$surface_container_high = rgba(3f3f46ff)

# Accents (Red + Steel Gradient)
\$primary = rgba(d63a4aff)
\$secondary = rgba(9e9ea0ff)
\$inactive_border = rgba(3f3f46ff)

# Text
\$on_surface = rgba(e5e5eaff)
\$on_primary = rgba(ffffffff)
EOF

# ---------------------------------------------------------
# 2. KITTY (current-theme.conf)
# ---------------------------------------------------------
cat <<EOF > "$KITTY_CONF.tmp"
# Scarlet_Night Kitty Theme
background            $BG
foreground            $FG
cursor                $ACCENT_PRI
selection_background  $SURFACE_HIGH
selection_foreground  $ACCENT_TXT
url_color             $ACCENT_PRI

active_border_color   $ACCENT_PRI
inactive_border_color $SURFACE_HIGH
active_tab_background $ACCENT_PRI
active_tab_foreground $ACCENT_TXT
inactive_tab_background $SURFACE
inactive_tab_foreground $FG

# ANSI Palette (Industrial Scale)
color0  #1c1c1e
color8  #3f3f46
color1  #b83e4a
color9  #d63a4a
color2  #9e9ea0
color10 #d4d4d6
color3  #d63a4a
color11 #e5e5ea
color4  #71717a
color12 #a1a1aa
color5  #d63a4a
color13 #ff5c6c
color6  #52525b
color14 #808080
color7  #d4d4d6
color15 #ffffff
EOF

# ---------------------------------------------------------
# 3. ROFI (colors.rasi) - FLAT DEFINITIONS
# ---------------------------------------------------------
cat <<EOF > "$ROFI_CONF.tmp"
* {
    /* Scarlet_Night Rofi Palette */

    /* Backgrounds */
    background:     $BG;
    surface:        $SURFACE;
    
    /* Text */
    on-background:  $FG;
    on-surface:     $FG;
    text-dim:       $TEXT_DIM;

    /* Primary Selection (Red Box / White Text) */
    primary:        $ACCENT_PRI;
    on-primary:     $ACCENT_TXT;
    
    /* Secondary (Steel) */
    secondary:      $ACCENT_SEC;
    on-secondary:   $BG;

    /* Status */
    active:         $ACCENT_PRI;
    selected:       $ACCENT_PRI;
    urgent:         $ERROR_COL;
    error:          $ERROR_COL;
    on-error:       $ACCENT_TXT;

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
theme[cpu_start]="#71717a"
theme[cpu_end]="$ACCENT_PRI"
theme[mem_start]="#71717a"
theme[mem_end]="$ACCENT_PRI"
theme[net_start]="#71717a"
theme[net_end]="$ACCENT_PRI"
theme[download_start]="#71717a"
theme[download_end]="$ACCENT_PRI"
theme[upload_start]="#71717a"
theme[upload_end]="$ACCENT_PRI"
EOF

# ---------------------------------------------------------
# 5. CAVA & APPLY
# ---------------------------------------------------------
cat <<EOF > "$CAVA_CONF.tmp"
[color]
gradient = 1
gradient_count = 6
# Iron -> Steel -> Red -> Bright Red
gradient_color_1 = '#3f3f46'
gradient_color_2 = '#52525b'
gradient_color_3 = '#71717a'
gradient_color_4 = '#b83e4a'
gradient_color_5 = '#d63a4a'
gradient_color_6 = '#ff5c6c'

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
