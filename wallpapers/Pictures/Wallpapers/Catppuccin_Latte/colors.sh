#!/bin/bash

# -----------------------------------------------------------------------------
# THEME: Catppuccin_Latte (Light Mode)
# DESCRIPTION: Soft White BG, Deep Slate Text, Mauve/Pink Accents.
# TYPE: Static Palette Injection (Light Mode Optimized)
# -----------------------------------------------------------------------------

# --- PATHS ---
HYPR_CONF="$HOME/.config/hypr/colors.conf"
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
ROFI_CONF="$HOME/.config/rofi/colors.rasi"
BTOP_THEME="$HOME/.config/btop/themes/matugen.theme"
CAVA_CONF="$HOME/.config/cava/config"

# --- PALETTE VARIABLES (Raw Hex) ---
BG="#eff1f5"              # Base White
FG="#4c4f69"              # Deep Slate Text
SURFACE="#ccd0da"         # Mantle (Darker for separation)
SURFACE_HIGH="#9ca0b0"    # Overlay (Used for Borders/Dimmed)

ACCENT_PRI="#8839ef"      # Mauve (Primary Selection)
ACCENT_TXT="#ffffff"      # White (Text on Selection)
ACCENT_SEC="#ea76cb"      # Pink (Secondary)

TEXT_DIM="#9ca0b0"        # Dimmed Text
BORDER_COL="#9ca0b0"      # Inactive Border
ERROR_COL="#d20f39"       # Red

# ---------------------------------------------------------
# 1. HYPRLAND (colors.conf)
# ---------------------------------------------------------
cat <<EOF > "$HYPR_CONF.tmp"
# Catppuccin_Latte Hyprland Palette

# Core (Light Mode)
\$background = rgba(eff1f5ff)
\$on_background = rgba(4c4f69ff)

# Surfaces
\$surface = rgba(ccd0daff)
\$surface_dim = rgba(eff1f5ff)
\$surface_container = rgba(ccd0daff)

# FIX: Define the variable causing the 'Red Bar' error
\$surface_container_high = rgba(9ca0b0ff)

# Accents (Mauve & Pink)
\$primary = rgba(8839efff)
\$secondary = rgba(ea76cbff)
\$inactive_border = rgba(9ca0b0ff)

# Text
\$on_surface = rgba(4c4f69ff)
\$on_primary = rgba(ffffffff)
EOF

# ---------------------------------------------------------
# 2. KITTY (current-theme.conf)
# ---------------------------------------------------------
cat <<EOF > "$KITTY_CONF.tmp"
# Catppuccin_Latte Kitty Theme
background            $BG
foreground            $FG
cursor                $ACCENT_PRI
selection_background  $ACCENT_SEC
selection_foreground  $BG
url_color             #1e66f5

active_border_color   $ACCENT_PRI
inactive_border_color $SURFACE_HIGH
active_tab_background $ACCENT_PRI
active_tab_foreground #ffffff
inactive_tab_background $SURFACE
inactive_tab_foreground $FG

# ANSI Palette (Latte Spectrum)
color0  #5c5f77
color8  #6c6f85
color1  #d20f39
color9  #e64553
color2  #40a02b
color10 #94e2d5
color3  #df8e1d
color11 #fe640b
color4  #1e66f5
color12 #7287fd
color5  #8839ef
color13 #ea76cb
color6  #209fb5
color14 #179299
color7  #acb0be
color15 #bcc0cc
EOF

# ---------------------------------------------------------
# 3. ROFI (colors.rasi) - FLAT DEFINITIONS
# ---------------------------------------------------------
# Using strict HEX definitions to ensure visibility and avoid recursion.
cat <<EOF > "$ROFI_CONF.tmp"
* {
    /* Catppuccin_Latte Rofi Palette (Light Mode) */

    /* Backgrounds */
    background:     $BG;
    surface:        $SURFACE;
    
    /* Text */
    on-background:  $FG;
    on-surface:     $FG;
    text-dim:       $TEXT_DIM;

    /* Primary Selection (Mauve Box / White Text) */
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
theme[title]="$FG"
theme[hi_fg]="$ACCENT_PRI"
theme[selected_bg]="$ACCENT_PRI"
theme[selected_fg]="$ACCENT_TXT"
theme[inactive_fg]="$TEXT_DIM"
theme[graph_text]="$FG"
theme[cpu_box]="$SURFACE"
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
# Blue -> Lavender -> Pink -> Mauve -> Red -> Orange
gradient_color_1 = '#1e66f5'
gradient_color_2 = '#7287fd'
gradient_color_3 = '#ea76cb'
gradient_color_4 = '#8839ef'
gradient_color_5 = '#d20f39'
gradient_color_6 = '#fe640b'

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
notify-send "Theme" "Catppuccin Latte Applied."
