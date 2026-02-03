#!/bin/bash

# -----------------------------------------------------------------------------
# THEME: Monochrome
# DESCRIPTION: Pure OLED Black, Stark White, and Silver Greys.
# TYPE: Static Palette Injection (True Noir / Ink & Paper)
# -----------------------------------------------------------------------------

# --- PATHS ---
HYPR_CONF="$HOME/.config/hypr/colors.conf"
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
ROFI_CONF="$HOME/.config/rofi/colors.rasi"
BTOP_THEME="$HOME/.config/btop/themes/matugen.theme"
CAVA_CONF="$HOME/.config/cava/config"

# --- PALETTE VARIABLES (Raw Hex) ---
BG="#000000"              # Pure Void
FG="#ffffff"              # Stark White
SURFACE="#1a1a1a"         # Dark Graphite
SURFACE_HIGH="#404040"    # Iron Grey (Borders/Dim)

ACCENT_PRI="#ffffff"      # Pure Light (Primary)
ACCENT_TXT="#000000"      # Ink Black (Text on White)
ACCENT_SEC="#808080"      # Neutral Grey (Secondary)

TEXT_DIM="#808080"        # Neutral Grey (Readable Dim Text)
BORDER_COL="#404040"      # Iron Grey
ERROR_COL="#ffffff"       # White (Strict Monochrome)

# ---------------------------------------------------------
# 1. HYPRLAND (colors.conf)
# ---------------------------------------------------------
cat <<EOF > "$HYPR_CONF.tmp"
# Monochrome Hyprland Palette

# Core
\$background = rgba(000000ff)
\$on_background = rgba(ffffffff)

# Surfaces
\$surface = rgba(1a1a1aff)
\$surface_dim = rgba(000000ff)
\$surface_container = rgba(1a1a1aff)

# FIX: Define the variable causing the 'Red Bar' error
\$surface_container_high = rgba(404040ff)

# Accents (White + Grey Gradient)
\$primary = rgba(ffffffff)
\$secondary = rgba(808080ff)
\$inactive_border = rgba(404040ff)

# Text
\$on_surface = rgba(ffffffff)
\$on_primary = rgba(000000ff)
EOF

# ---------------------------------------------------------
# 2. KITTY (current-theme.conf)
# ---------------------------------------------------------
cat <<EOF > "$KITTY_CONF.tmp"
# Monochrome Kitty Theme
background            $BG
foreground            $FG
cursor                $ACCENT_PRI
selection_background  $ACCENT_PRI
selection_foreground  $ACCENT_TXT
url_color             #a0a0a0

active_border_color   $ACCENT_PRI
inactive_border_color $SURFACE_HIGH
active_tab_background $ACCENT_PRI
active_tab_foreground $ACCENT_TXT
inactive_tab_background $SURFACE
inactive_tab_foreground $FG

# ANSI Palette (Strict Grayscale Ramp)
color0  #1a1a1a
color8  #404040
color1  #ffffff
color9  #e0e0e0
color2  #ffffff
color10 #cccccc
color3  #ffffff
color11 #b3b3b3
color4  #ffffff
color12 #999999
color5  #ffffff
color13 #808080
color6  #ffffff
color14 #666666
color7  #e0e0e0
color15 #ffffff
EOF

# ---------------------------------------------------------
# 3. ROFI (colors.rasi) - FLAT DEFINITIONS
# ---------------------------------------------------------
cat <<EOF > "$ROFI_CONF.tmp"
* {
    /* Monochrome Rofi Palette */

    /* Backgrounds */
    background:     $BG;
    surface:        $SURFACE;
    
    /* Text */
    on-background:  $FG;
    on-surface:     $FG;
    text-dim:       $TEXT_DIM;

    /* Primary Selection (White Box / Black Text) */
    primary:        $ACCENT_PRI;
    on-primary:     $ACCENT_TXT;
    
    /* Secondary (Grey) */
    secondary:      $ACCENT_SEC;
    on-secondary:   $FG;

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
theme[cpu_start]="$SURFACE_HIGH"
theme[cpu_end]="$ACCENT_PRI"
theme[mem_start]="$SURFACE_HIGH"
theme[mem_end]="$ACCENT_PRI"
theme[net_start]="$SURFACE_HIGH"
theme[net_end]="$ACCENT_PRI"
theme[download_start]="$SURFACE_HIGH"
theme[download_end]="$ACCENT_PRI"
theme[upload_start]="$SURFACE_HIGH"
theme[upload_end]="$ACCENT_PRI"
EOF

# ---------------------------------------------------------
# 5. CAVA & APPLY
# ---------------------------------------------------------
cat <<EOF > "$CAVA_CONF.tmp"
[color]
gradient = 1
gradient_count = 6
# Dark Grey -> Silver -> White
gradient_color_1 = '#333333'
gradient_color_2 = '#555555'
gradient_color_3 = '#777777'
gradient_color_4 = '#999999'
gradient_color_5 = '#bbbbbb'
gradient_color_6 = '#ffffff'

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
