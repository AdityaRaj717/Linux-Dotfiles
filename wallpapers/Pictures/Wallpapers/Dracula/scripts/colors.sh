#!/bin/bash

# -----------------------------------------------------------------------------
# THEME: Dracula
# DESCRIPTION: The Official Vampire Palette. Dark Blue-Grey, Purple, and Pink.
# TYPE: Static Palette Injection (Official Spec)
# -----------------------------------------------------------------------------

# --- PATHS ---
HYPR_CONF="$HOME/.config/hypr/colors.conf"
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
ROFI_CONF="$HOME/.config/rofi/colors.rasi"
BTOP_THEME="$HOME/.config/btop/themes/matugen.theme"
CAVA_CONF="$HOME/.config/cava/config"

# --- PALETTE VARIABLES (Raw Hex) ---
BG="#282a36"              # Dracula Background
FG="#f8f8f2"              # Off-White
SURFACE="#44475a"         # Current Line / Selection
SURFACE_HIGH="#6272a4"    # Comment (Used for Borders/Dimmed)

ACCENT_PRI="#bd93f9"      # Dracula Purple
ACCENT_TXT="#282a36"      # Dark Text (for contrast on Purple)
ACCENT_SEC="#ff79c6"      # Dracula Pink

TEXT_DIM="#6272a4"        # Comment Color
BORDER_COL="#6272a4"      # Comment Color
ERROR_COL="#ff5555"       # Red

# ---------------------------------------------------------
# 1. HYPRLAND (colors.conf)
# ---------------------------------------------------------
cat <<EOF > "$HYPR_CONF.tmp"
# Dracula Hyprland Palette

# Core
\$background = rgba(282a36ff)
\$on_background = rgba(f8f8f2ff)

# Surfaces
\$surface = rgba(44475aff)
\$surface_dim = rgba(282a36ff)
\$surface_container = rgba(44475aff)

# FIX: Define the variable causing the 'Red Bar' error
\$surface_container_high = rgba(6272a4ff)

# Accents (Purple + Pink Gradient)
\$primary = rgba(bd93f9ff)
\$secondary = rgba(ff79c6ff)
\$inactive_border = rgba(6272a4ff)

# Text
\$on_surface = rgba(f8f8f2ff)
\$on_primary = rgba(282a36ff)
EOF

# ---------------------------------------------------------
# 2. KITTY (current-theme.conf)
# ---------------------------------------------------------
cat <<EOF > "$KITTY_CONF.tmp"
# Dracula Kitty Theme
background            $BG
foreground            $FG
cursor                $ACCENT_SEC
selection_background  $SURFACE
selection_foreground  $FG
url_color             #8be9fd

active_border_color   $ACCENT_PRI
inactive_border_color $SURFACE_HIGH
active_tab_background $ACCENT_PRI
active_tab_foreground $ACCENT_TXT
inactive_tab_background $SURFACE
inactive_tab_foreground $FG

# ANSI Palette (Official Spec)
color0  #21222c
color8  #6272a4
color1  #ff5555
color9  #ff6e6e
color2  #50fa7b
color10 #69ff94
color3  #f1fa8c
color11 #ffffa5
color4  #bd93f9
color12 #d6acff
color5  #ff79c6
color13 #ff92df
color6  #8be9fd
color14 #a4ffff
color7  #f8f8f2
color15 #ffffff
EOF

# ---------------------------------------------------------
# 3. ROFI (colors.rasi) - FLAT DEFINITIONS
# ---------------------------------------------------------
cat <<EOF > "$ROFI_CONF.tmp"
* {
    /* Dracula Rofi Palette */

    /* Backgrounds */
    background:     $BG;
    surface:        $SURFACE;
    
    /* Text */
    on-background:  $FG;
    on-surface:     $FG;
    text-dim:       $TEXT_DIM;

    /* Primary Selection (Purple Box / Dark Text) */
    primary:        $ACCENT_PRI;
    on-primary:     $ACCENT_TXT;
    
    /* Secondary (Pink) */
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
theme[graph_text]="#8be9fd"
theme[cpu_box]="$SURFACE"
theme[mem_box]="$SURFACE"
theme[net_box]="$SURFACE"
theme[proc_box]="$SURFACE"
theme[div_line]="$SURFACE_HIGH"
theme[cpu_start]="#50fa7b"
theme[cpu_end]="#ff5555"
theme[mem_start]="#50fa7b"
theme[mem_end]="#ff5555"
theme[net_start]="#50fa7b"
theme[net_end]="#ff5555"
theme[download_start]="#50fa7b"
theme[download_end]="#ff5555"
theme[upload_start]="#50fa7b"
theme[upload_end]="#ff5555"
EOF

# ---------------------------------------------------------
# 5. CAVA & APPLY
# ---------------------------------------------------------
cat <<EOF > "$CAVA_CONF.tmp"
[color]
gradient = 1
gradient_count = 6
# Purple -> Pink -> Orange -> Yellow -> Green
gradient_color_1 = '#bd93f9'
gradient_color_2 = '#ff79c6'
gradient_color_3 = '#ff5555'
gradient_color_4 = '#ffb86c'
gradient_color_5 = '#f1fa8c'
gradient_color_6 = '#50fa7b'

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
