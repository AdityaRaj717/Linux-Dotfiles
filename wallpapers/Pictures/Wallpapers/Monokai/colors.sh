#!/bin/bash

# -----------------------------------------------------------------------------
# THEME: Monokai
# DESCRIPTION: Warm Dark Grey, Hot Pink, Acid Green. (Developer Classic)
# TYPE: Static Palette Injection (Code Editor Style)
# -----------------------------------------------------------------------------

# --- PATHS ---
HYPR_CONF="$HOME/.config/hypr/colors.conf"
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
ROFI_CONF="$HOME/.config/rofi/colors.rasi"
BTOP_THEME="$HOME/.config/btop/themes/matugen.theme"
CAVA_CONF="$HOME/.config/cava/config"

# --- PALETTE VARIABLES (Raw Hex) ---
BG="#272822"              # Classic Monokai Dark Grey
FG="#f8f8f2"              # Off-White
SURFACE="#3e3d32"         # Lighter Warm Grey
SURFACE_HIGH="#75715e"    # Comment Grey (Borders/Dim)

ACCENT_PRI="#f92672"      # Monokai Pink
ACCENT_TXT="#272822"      # Dark Background (Text on Pink)
ACCENT_SEC="#a6e22e"      # Acid Green

TEXT_DIM="#75715e"        # Comment Grey
BORDER_COL="#75715e"      # Comment Grey
ERROR_COL="#f92672"       # Pink/Red

# ---------------------------------------------------------
# 1. HYPRLAND (colors.conf)
# ---------------------------------------------------------
cat <<EOF > "$HYPR_CONF.tmp"
# Monokai Hyprland Palette

# Core
\$background = rgba(272822ff)
\$on_background = rgba(f8f8f2ff)

# Surfaces
\$surface = rgba(3e3d32ff)
\$surface_dim = rgba(272822ff)
\$surface_container = rgba(3e3d32ff)

# FIX: Define the variable causing the 'Red Bar' error
\$surface_container_high = rgba(75715eff)

# Accents (Pink + Green Gradient)
\$primary = rgba(f92672ff)
\$secondary = rgba(a6e22eff)
\$inactive_border = rgba(75715eff)

# Text
\$on_surface = rgba(f8f8f2ff)
\$on_primary = rgba(272822ff)
EOF

# ---------------------------------------------------------
# 2. KITTY (current-theme.conf)
# ---------------------------------------------------------
cat <<EOF > "$KITTY_CONF.tmp"
# Monokai Kitty Theme
background            $BG
foreground            $FG
cursor                $ACCENT_PRI
selection_background  #49483e
selection_foreground  $FG
url_color             #66d9ef

active_border_color   $ACCENT_PRI
inactive_border_color $SURFACE_HIGH
active_tab_background $ACCENT_PRI
active_tab_foreground $ACCENT_TXT
inactive_tab_background $SURFACE
inactive_tab_foreground $FG

# ANSI Palette (Official Monokai)
color0  #272822
color8  #75715e
color1  #f92672
color9  #f92672
color2  #a6e22e
color10 #a6e22e
color3  #f4bf75
color11 #f4bf75
color4  #66d9ef
color12 #66d9ef
color5  #ae81ff
color13 #ae81ff
color6  #a1efe4
color14 #a1efe4
color7  #f8f8f2
color15 #f9f8f5
EOF

# ---------------------------------------------------------
# 3. ROFI (colors.rasi) - FLAT DEFINITIONS
# ---------------------------------------------------------
cat <<EOF > "$ROFI_CONF.tmp"
* {
    /* Monokai Rofi Palette */

    /* Backgrounds */
    background:     $BG;
    surface:        $SURFACE;
    
    /* Text */
    on-background:  $FG;
    on-surface:     $FG;
    text-dim:       $TEXT_DIM;

    /* Primary Selection (Pink Box / Dark Text) */
    primary:        $ACCENT_PRI;
    on-primary:     $ACCENT_TXT;
    
    /* Secondary (Green) */
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
theme[graph_text]="#66d9ef"
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
# Pink -> Purple -> Blue -> Green -> Yellow
gradient_color_1 = '#f92672'
gradient_color_2 = '#ae81ff'
gradient_color_3 = '#66d9ef'
gradient_color_4 = '#a6e22e'
gradient_color_5 = '#e6db74'
gradient_color_6 = '#fd971f'

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
notify-send "Theme" "Monokai Applied."
