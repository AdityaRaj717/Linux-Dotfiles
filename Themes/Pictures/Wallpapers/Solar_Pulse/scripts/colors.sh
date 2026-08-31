#!/bin/bash

# -----------------------------------------------------------------------------
# THEME: Solar_Pulse
# DESCRIPTION: Deep Void, Solar Gold, Magma Orange. (High Energy Interface)
# TYPE: Static Palette Injection
# -----------------------------------------------------------------------------

# --- PATHS ---
HYPR_CONF="$HOME/.config/hypr/colors.conf"
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
ROFI_CONF="$HOME/.config/rofi/colors.rasi"
BTOP_THEME="$HOME/.config/btop/themes/matugen.theme"
CAVA_CONF="$HOME/.config/cava/config"

# --- PALETTE VARIABLES (Raw Hex) ---
BG="#0a0b10"              # Deep Space
FG="#fffce6"              # Starlight (Bright Warm White)
SURFACE="#14161f"         # Event Horizon
SURFACE_HIGH="#4d3d1a"    # Eclipse Shadow (Borders/Dim)

ACCENT_PRI="#ffcc00"      # Solar Gold
ACCENT_TXT="#0a0b10"      # Void (Dark Text on Gold)
ACCENT_SEC="#ff6600"      # Solar Flare (Orange)

TEXT_DIM="#4d3d1a"        # Eclipse Shadow
BORDER_COL="#4d3d1a"      # Eclipse Shadow
ERROR_COL="#ff3333"       # Red Dwarf

# ---------------------------------------------------------
# 1. HYPRLAND (colors.conf)
# ---------------------------------------------------------
cat <<EOF > "$HYPR_CONF.tmp"
# Solar_Pulse Hyprland Palette

# Core
\$background = rgba(0a0b10ff)
\$on_background = rgba(fffce6ff)

# Surfaces
\$surface = rgba(14161fff)
\$surface_dim = rgba(0a0b10ff)
\$surface_container = rgba(14161fff)

# FIX: Define the variable causing the 'Red Bar' error
\$surface_container_high = rgba(4d3d1aff)

# Accents (Gold + Orange Gradient)
\$primary = rgba(ffcc00ff)
\$secondary = rgba(ff6600ff)
\$inactive_border = rgba(4d3d1aff)

# Text
\$on_surface = rgba(fffce6ff)
\$on_primary = rgba(0a0b10ff)
EOF

# ---------------------------------------------------------
# 2. KITTY (current-theme.conf)
# ---------------------------------------------------------
cat <<EOF > "$KITTY_CONF.tmp"
# Solar_Pulse Kitty Theme
background            $BG
foreground            $FG
cursor                $ACCENT_PRI
selection_background  $ACCENT_SEC
selection_foreground  $FG
url_color             #ff9900

active_border_color   $ACCENT_PRI
inactive_border_color $SURFACE_HIGH
active_tab_background $ACCENT_PRI
active_tab_foreground $ACCENT_TXT
inactive_tab_background $SURFACE
inactive_tab_foreground $FG

# ANSI Palette (The Spectrum)
color0  #14161f
color8  #333333
color1  #ff3333
color9  #ff5555
color2  #99cc00
color10 #b3e600
color3  #ffcc00
color11 #ffe066
color4  #00aaff
color12 #66ccff
color5  #cc00ff
color13 #e680ff
color6  #00ccff
color14 #80e5ff
color7  #e6e6e6
color15 #ffffff
EOF

# ---------------------------------------------------------
# 3. ROFI (colors.rasi) - FLAT DEFINITIONS
# ---------------------------------------------------------
cat <<EOF > "$ROFI_CONF.tmp"
* {
    /* Solar_Pulse Rofi Palette */

    /* Backgrounds */
    background:     $BG;
    surface:        $SURFACE;
    
    /* Text */
    on-background:  $FG;
    on-surface:     $FG;
    text-dim:       $TEXT_DIM;

    /* Primary Selection (Gold Box / Void Text) */
    primary:        $ACCENT_PRI;
    on-primary:     $ACCENT_TXT;
    
    /* Secondary (Orange) */
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
theme[graph_text]="#ff9900"
theme[cpu_box]="$SURFACE"
theme[mem_box]="$SURFACE"
theme[net_box]="$SURFACE"
theme[proc_box]="$SURFACE"
theme[div_line]="$SURFACE_HIGH"
theme[cpu_start]="#ff6600"
theme[cpu_end]="$ACCENT_PRI"
theme[mem_start]="#ff6600"
theme[mem_end]="$ACCENT_PRI"
theme[net_start]="#ff6600"
theme[net_end]="$ACCENT_PRI"
theme[download_start]="#ff6600"
theme[download_end]="$ACCENT_PRI"
theme[upload_start]="#ff6600"
theme[upload_end]="$ACCENT_PRI"
EOF

# ---------------------------------------------------------
# 5. CAVA & APPLY
# ---------------------------------------------------------
cat <<EOF > "$CAVA_CONF.tmp"
[color]
gradient = 1
gradient_count = 6
# Deep Red -> Magma -> Orange -> Gold -> White
gradient_color_1 = '#cc0000'
gradient_color_2 = '#ff3300'
gradient_color_3 = '#ff6600'
gradient_color_4 = '#ff9900'
gradient_color_5 = '#ffcc00'
gradient_color_6 = '#ffff00'

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
