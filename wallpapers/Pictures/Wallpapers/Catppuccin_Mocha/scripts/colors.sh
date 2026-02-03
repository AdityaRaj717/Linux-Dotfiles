#!/bin/bash

# -----------------------------------------------------------------------------
# THEME: Catppuccin_Mocha
# DESCRIPTION: Deep Dark Blue-Grey, Mauve, and Blue/Pink Accents.
# TYPE: Static Palette Injection (Dark Mode Optimized)
# -----------------------------------------------------------------------------

# --- PATHS ---
HYPR_CONF="$HOME/.config/hypr/colors.conf"
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
ROFI_CONF="$HOME/.config/rofi/colors.rasi"
BTOP_THEME="$HOME/.config/btop/themes/matugen.theme"
CAVA_CONF="$HOME/.config/cava/config"

# --- PALETTE VARIABLES (Raw Hex) ---
BG="#1e1e2e"              # Base
FG="#cdd6f4"              # Text
SURFACE="#313244"         # Surface0
SURFACE_HIGH="#45475a"    # Surface1 (Used for Borders/Dimmed)

ACCENT_PRI="#cba6f7"      # Mauve
ACCENT_TXT="#11111b"      # Crust (Dark text for high contrast)
ACCENT_SEC="#89b4fa"      # Blue (Cool tone for borders)
ACCENT_TRI="#f5c2e7"      # Pink (Secondary highlights)

TEXT_DIM="#6c7086"        # Overlay0 (Standard Dim Text)
BORDER_COL="#45475a"      # Surface1
ERROR_COL="#f38ba8"       # Red

# ---------------------------------------------------------
# 1. HYPRLAND (colors.conf)
# ---------------------------------------------------------
cat <<EOF > "$HYPR_CONF.tmp"
# Catppuccin_Mocha Hyprland Palette

# Core
\$background = rgba(1e1e2eff)
\$on_background = rgba(cdd6f4ff)

# Surfaces
\$surface = rgba(313244ff)
\$surface_dim = rgba(1e1e2eff)
\$surface_container = rgba(313244ff)

# FIX: Define the variable causing the 'Red Bar' error
\$surface_container_high = rgba(45475aff)

# Accents (Mauve + Blue Gradient)
\$primary = rgba(cba6f7ff)
\$secondary = rgba(89b4faff)
\$inactive_border = rgba(45475aff)

# Text
\$on_surface = rgba(cdd6f4ff)
\$on_primary = rgba(11111bff)
EOF

# ---------------------------------------------------------
# 2. KITTY (current-theme.conf)
# ---------------------------------------------------------
cat <<EOF > "$KITTY_CONF.tmp"
# Catppuccin_Mocha Kitty Theme
background            $BG
foreground            $FG
cursor                $ACCENT_PRI
selection_background  #585b70
selection_foreground  $FG
url_color             #f5e0dc

active_border_color   $ACCENT_PRI
inactive_border_color $SURFACE_HIGH
active_tab_background $ACCENT_PRI
active_tab_foreground #11111b
inactive_tab_background $SURFACE
inactive_tab_foreground $FG

# ANSI Palette (Mocha Spectrum)
color0  #45475a
color8  #585b70
color1  #f38ba8
color9  #f38ba8
color2  #a6e3a1
color10 #a6e3a1
color3  #f9e2af
color11 #f9e2af
color4  #89b4fa
color12 #89b4fa
color5  #cba6f7
color13 #cba6f7
color6  #94e2d5
color14 #94e2d5
color7  #bac2de
color15 #a6adc8
EOF

# ---------------------------------------------------------
# 3. ROFI (colors.rasi) - FLAT DEFINITIONS
# ---------------------------------------------------------
cat <<EOF > "$ROFI_CONF.tmp"
* {
    /* Catppuccin_Mocha Rofi Palette */

    /* Backgrounds */
    background:     $BG;
    surface:        $SURFACE;
    
    /* Text */
    on-background:  $FG;
    on-surface:     $FG;
    text-dim:       $TEXT_DIM;

    /* Primary Selection (Mauve Box / Dark Text) */
    primary:        $ACCENT_PRI;
    on-primary:     #1e1e2e;
    
    /* Secondary (Blue) */
    secondary:      $ACCENT_SEC;
    on-secondary:   #1e1e2e;

    /* Status */
    active:         $ACCENT_PRI;
    selected:       $ACCENT_PRI;
    urgent:         $ERROR_COL;
    error:          $ERROR_COL;
    on-error:       $BG;

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
theme[title]="$FG"
theme[hi_fg]="$ACCENT_PRI"
theme[selected_bg]="$ACCENT_PRI"
theme[selected_fg]="#1e1e2e"
theme[inactive_fg]="$TEXT_DIM"
theme[graph_text]="$FG"
theme[cpu_box]="$SURFACE"
theme[mem_box]="$SURFACE"
theme[net_box]="$SURFACE"
theme[proc_box]="$SURFACE"
theme[div_line]="$SURFACE_HIGH"
theme[cpu_start]="#f38ba8"
theme[cpu_end]="$ACCENT_PRI"
theme[mem_start]="#f38ba8"
theme[mem_end]="$ACCENT_PRI"
theme[net_start]="#f38ba8"
theme[net_end]="$ACCENT_PRI"
theme[download_start]="#f38ba8"
theme[download_end]="$ACCENT_PRI"
theme[upload_start]="#f38ba8"
theme[upload_end]="$ACCENT_PRI"
EOF

# ---------------------------------------------------------
# 5. CAVA & APPLY
# ---------------------------------------------------------
cat <<EOF > "$CAVA_CONF.tmp"
[color]
gradient = 1
gradient_count = 6
# Deep Purple -> Mauve -> Pink -> Peach
gradient_color_1 = '#89b4fa'
gradient_color_2 = '#cba6f7'
gradient_color_3 = '#f5c2e7'
gradient_color_4 = '#eba0ac'
gradient_color_5 = '#fab387'
gradient_color_6 = '#f9e2af'

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
