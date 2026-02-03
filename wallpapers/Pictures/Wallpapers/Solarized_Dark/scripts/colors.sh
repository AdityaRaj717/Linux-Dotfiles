#!/bin/bash

# -----------------------------------------------------------------------------
# THEME: Solarized_Dark
# DESCRIPTION: Deep Petrol, Cream Text, Cyan & Amber. (High Visibility Edition)
# TYPE: Static Palette Injection (Solarized Spec)
# -----------------------------------------------------------------------------

# --- PATHS ---
HYPR_CONF="$HOME/.config/hypr/colors.conf"
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
ROFI_CONF="$HOME/.config/rofi/colors.rasi"
BTOP_THEME="$HOME/.config/btop/themes/matugen.theme"
CAVA_CONF="$HOME/.config/cava/config"

# --- PALETTE VARIABLES (Raw Hex) ---
BG="#002b36"              # Deep Petrol (Base03)
FG="#fdf6e3"              # Cream (Base3 - Boosted Brightness)
SURFACE="#073642"         # Lighter Teal (Base02)
SURFACE_HIGH="#586e75"    # Muted Grey-Teal (Base01 - Borders/Dim)

ACCENT_PRI="#2aa198"      # Cyan
ACCENT_TXT="#002b36"      # Dark Text (on Cyan)
ACCENT_SEC="#b58900"      # Amber

TEXT_DIM="#586e75"        # Muted Grey-Teal
BORDER_COL="#586e75"      # Muted Grey-Teal
ERROR_COL="#dc322f"       # Red

# ---------------------------------------------------------
# 1. HYPRLAND (colors.conf)
# ---------------------------------------------------------
cat <<EOF > "$HYPR_CONF.tmp"
# Solarized_Dark Hyprland Palette

# Core
\$background = rgba(002b36ff)
\$on_background = rgba(fdf6e3ff)

# Surfaces
\$surface = rgba(073642ff)
\$surface_dim = rgba(002b36ff)
\$surface_container = rgba(073642ff)

# FIX: Define the variable causing the 'Red Bar' error
\$surface_container_high = rgba(586e75ff)

# Accents (Cyan + Amber Gradient)
\$primary = rgba(2aa198ff)
\$secondary = rgba(b58900ff)
\$inactive_border = rgba(586e75ff)

# Text
\$on_surface = rgba(fdf6e3ff)
\$on_primary = rgba(002b36ff)
EOF

# ---------------------------------------------------------
# 2. KITTY (current-theme.conf)
# ---------------------------------------------------------
cat <<EOF > "$KITTY_CONF.tmp"
# Solarized_Dark Kitty Theme
background            $BG
foreground            $FG
cursor                #d33682
selection_background  $SURFACE
selection_foreground  $FG
url_color             #268bd2

active_border_color   $ACCENT_PRI
inactive_border_color $SURFACE_HIGH
active_tab_background $ACCENT_PRI
active_tab_foreground $ACCENT_TXT
inactive_tab_background $SURFACE
inactive_tab_foreground $FG

# ANSI Palette (Official Solarized)
color0  #073642
color8  #002b36
color1  #dc322f
color9  #cb4b16
color2  #859900
color10 #586e75
color3  #b58900
color11 #657b83
color4  #268bd2
color12 #839496
color5  #d33682
color13 #6c71c4
color6  #2aa198
color14 #93a1a1
color7  #eee8d5
color15 #fdf6e3
EOF

# ---------------------------------------------------------
# 3. ROFI (colors.rasi) - FLAT DEFINITIONS
# ---------------------------------------------------------
cat <<EOF > "$ROFI_CONF.tmp"
* {
    /* Solarized_Dark Rofi Palette */

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
    
    /* Secondary (Amber) */
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
theme[graph_text]="#268bd2"
theme[cpu_box]="$SURFACE"
theme[mem_box]="$SURFACE"
theme[net_box]="$SURFACE"
theme[proc_box]="$SURFACE"
theme[div_line]="$SURFACE_HIGH"
theme[cpu_start]="#859900"
theme[cpu_end]="#dc322f"
theme[mem_start]="#859900"
theme[mem_end]="#dc322f"
theme[net_start]="#859900"
theme[net_end]="#dc322f"
theme[download_start]="#859900"
theme[download_end]="#dc322f"
theme[upload_start]="#859900"
theme[upload_end]="#dc322f"
EOF

# ---------------------------------------------------------
# 5. CAVA & APPLY
# ---------------------------------------------------------
cat <<EOF > "$CAVA_CONF.tmp"
[color]
gradient = 1
gradient_count = 6
# Cyan -> Blue -> Green -> Yellow -> Orange -> Red
gradient_color_1 = '#2aa198'
gradient_color_2 = '#268bd2'
gradient_color_3 = '#859900'
gradient_color_4 = '#b58900'
gradient_color_5 = '#cb4b16'
gradient_color_6 = '#dc322f'

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
