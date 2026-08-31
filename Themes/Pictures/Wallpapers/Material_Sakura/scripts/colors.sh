#!/bin/bash

# -----------------------------------------------------------------------------
# THEME: Material_Sakura (Light Mode)
# DESCRIPTION: Warm Paper White, Ink Black Text, Deep Rose & Sage Accents.
# TYPE: Static Palette Injection (Material You / Light Mode Optimized)
# -----------------------------------------------------------------------------

# --- PATHS ---
HYPR_CONF="$HOME/.config/hypr/colors.conf"
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
ROFI_CONF="$HOME/.config/rofi/colors.rasi"
BTOP_THEME="$HOME/.config/btop/themes/matugen.theme"
CAVA_CONF="$HOME/.config/cava/config"

# --- PALETTE VARIABLES (Raw Hex) ---
BG="#fff8f9"              # Sakura Paper (Warm White)
FG="#1c1b1f"              # Ink Black (High Contrast)
SURFACE="#f3e1e6"         # Pale Blush
SURFACE_HIGH="#9c8e93"    # Warm Taupe (Borders/Dim)

ACCENT_PRI="#d65d7e"      # Deep Rose (Primary)
ACCENT_TXT="#ffffff"      # Pure White (Text on Rose)
ACCENT_SEC="#7fa086"      # Sage Green (Secondary)

TEXT_DIM="#9c8e93"        # Warm Taupe
BORDER_COL="#9c8e93"      # Warm Taupe
ERROR_COL="#ba1a1a"       # Material Red

# ---------------------------------------------------------
# 1. HYPRLAND (colors.conf)
# ---------------------------------------------------------
cat <<EOF > "$HYPR_CONF.tmp"
# Material_Sakura Hyprland Palette

# Core (Light Mode)
\$background = rgba(fff8f9ff)
\$on_background = rgba(1c1b1fff)

# Surfaces
\$surface = rgba(f3e1e6ff)
\$surface_dim = rgba(fff8f9ff)
\$surface_container = rgba(f3e1e6ff)

# FIX: Define the variable causing the 'Red Bar' error
\$surface_container_high = rgba(9c8e93ff)

# Accents (Rose + Sage Gradient)
\$primary = rgba(d65d7eff)
\$secondary = rgba(7fa086ff)
\$inactive_border = rgba(9c8e93ff)

# Text
\$on_surface = rgba(1c1b1fff)
\$on_primary = rgba(ffffffff)
EOF

# ---------------------------------------------------------
# 2. KITTY (current-theme.conf)
# ---------------------------------------------------------
cat <<EOF > "$KITTY_CONF.tmp"
# Material_Sakura Kitty Theme
background            $BG
foreground            $FG
cursor                $ACCENT_PRI
selection_background  $SURFACE
selection_foreground  $FG
url_color             $ACCENT_PRI

active_border_color   $ACCENT_PRI
inactive_border_color $SURFACE_HIGH
active_tab_background $ACCENT_PRI
active_tab_foreground $ACCENT_TXT
inactive_tab_background $SURFACE
inactive_tab_foreground $FG

# ANSI Palette (Material Nature Spectrum)
color0  #1c1b1f
color8  #6e676e
color1  #ba1a1a
color9  #ff5449
color2  #7fa086
color10 #96b89d
color3  #e6c15c
color11 #f5d47a
color4  #5d8aa8
color12 #7ba3bf
color5  #d65d7e
color13 #f08ba6
color6  #6b8c75
color14 #8cb097
color7  #1c1b1f
color15 #9c8e93
EOF

# ---------------------------------------------------------
# 3. ROFI (colors.rasi) - FLAT DEFINITIONS
# ---------------------------------------------------------
# Using strict HEX definitions to ensure visibility and avoid recursion.
cat <<EOF > "$ROFI_CONF.tmp"
* {
    /* Material_Sakura Rofi Palette (Light Mode) */

    /* Backgrounds */
    background:     $BG;
    surface:        $SURFACE;
    
    /* Text */
    on-background:  $FG;
    on-surface:     $FG;
    text-dim:       $TEXT_DIM;

    /* Primary Selection (Rose Box / White Text) */
    primary:        $ACCENT_PRI;
    on-primary:     $ACCENT_TXT;
    
    /* Secondary (Sage) */
    secondary:      $ACCENT_SEC;
    on-secondary:   $ACCENT_TXT;

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
theme[cpu_box]="$SURFACE"
theme[selected_bg]="$ACCENT_PRI"
theme[selected_fg]="$ACCENT_TXT"
theme[graph_text]="$FG"
theme[hi_fg]="$ACCENT_PRI"
theme[inactive_fg]="$TEXT_DIM"
theme[mem_box]="$SURFACE"
theme[net_box]="$SURFACE"
theme[proc_box]="$SURFACE"
theme[div_line]="$SURFACE_HIGH"
theme[cpu_start]="$ACCENT_SEC"
theme[cpu_end]="$ACCENT_PRI"
theme[mem_start]="$ACCENT_SEC"
theme[mem_end]="$ACCENT_PRI"
theme[net_start]="$ACCENT_SEC"
theme[net_end]="$ACCENT_PRI"
theme[download_start]="$ACCENT_SEC"
theme[download_end]="$ACCENT_PRI"
theme[upload_start]="$ACCENT_SEC"
theme[upload_end]="$ACCENT_PRI"
EOF

# ---------------------------------------------------------
# 5. CAVA & APPLY
# ---------------------------------------------------------
cat <<EOF > "$CAVA_CONF.tmp"
[color]
gradient = 1
gradient_count = 6
# Sage -> Pollen -> Soft Pink -> Deep Rose -> Red
gradient_color_1 = '#7fa086'
gradient_color_2 = '#96b89d'
gradient_color_3 = '#e6c15c'
gradient_color_4 = '#f08ba6'
gradient_color_5 = '#d65d7e'
gradient_color_6 = '#ba1a1a'

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
