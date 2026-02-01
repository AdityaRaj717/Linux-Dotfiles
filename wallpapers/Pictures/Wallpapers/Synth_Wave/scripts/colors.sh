#!/bin/bash

# -----------------------------------------------------------------------------
# THEME: Synth_Wave
# DESCRIPTION: Void Purple, Neon Magenta, Electric Cyan. (80s Retro Futurism)
# TYPE: Static Palette Injection
# -----------------------------------------------------------------------------

# --- PATHS ---
HYPR_CONF="$HOME/.config/hypr/colors.conf"
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
ROFI_CONF="$HOME/.config/rofi/colors.rasi"
BTOP_THEME="$HOME/.config/btop/themes/matugen.theme"
CAVA_CONF="$HOME/.config/cava/config"

# --- PALETTE VARIABLES (Raw Hex) ---
BG="#13001a"              # Void Purple
FG="#ffffff"              # Pure White
SURFACE="#2a003b"         # Deep Plum
SURFACE_HIGH="#530075"    # Muted Violet (Borders/Dim)

ACCENT_PRI="#ff007c"      # Neon Magenta
ACCENT_TXT="#ffffff"      # White (Text on Magenta)
ACCENT_SEC="#00f0ff"      # Electric Cyan

TEXT_DIM="#530075"        # Muted Violet
BORDER_COL="#530075"      # Muted Violet
ERROR_COL="#ff2a2a"       # Laser Red

# ---------------------------------------------------------
# 1. HYPRLAND (colors.conf)
# ---------------------------------------------------------
cat <<EOF > "$HYPR_CONF.tmp"
# Synth_Wave Hyprland Palette

# Core
\$background = rgba(13001aff)
\$on_background = rgba(ffffffff)

# Surfaces
\$surface = rgba(2a003bff)
\$surface_dim = rgba(13001aff)
\$surface_container = rgba(2a003bff)

# FIX: Define the variable causing the 'Red Bar' error
\$surface_container_high = rgba(530075ff)

# Accents (Magenta + Cyan Gradient)
\$primary = rgba(ff007cff)
\$secondary = rgba(00f0ffff)
\$inactive_border = rgba(530075ff)

# Text
\$on_surface = rgba(ffffffff)
\$on_primary = rgba(ffffffff)
EOF

# ---------------------------------------------------------
# 2. KITTY (current-theme.conf)
# ---------------------------------------------------------
cat <<EOF > "$KITTY_CONF.tmp"
# Synth_Wave Kitty Theme
background            $BG
foreground            $FG
cursor                $ACCENT_SEC
selection_background  $ACCENT_PRI
selection_foreground  $FG
url_color             $ACCENT_SEC

active_border_color   $ACCENT_PRI
inactive_border_color $SURFACE_HIGH
active_tab_background $ACCENT_PRI
active_tab_foreground $FG
inactive_tab_background $SURFACE
inactive_tab_foreground $FG

# ANSI Palette (Neon Night)
color0  #2a003b
color8  #530075
color1  #ff2a2a
color9  #ff5555
color2  #00f0ff
color10 #80faff
color3  #ffd700
color11 #ffe066
color4  #7a00cc
color12 #a64dff
color5  #ff007c
color13 #ff66b3
color6  #00f0ff
color14 #ccfaff
color7  #e0e0e0
color15 #ffffff
EOF

# ---------------------------------------------------------
# 3. ROFI (colors.rasi) - FLAT DEFINITIONS
# ---------------------------------------------------------
cat <<EOF > "$ROFI_CONF.tmp"
* {
    /* Synth_Wave Rofi Palette */

    /* Backgrounds */
    background:     $BG;
    surface:        $SURFACE;
    
    /* Text */
    on-background:  $FG;
    on-surface:     $FG;
    text-dim:       $TEXT_DIM;

    /* Primary Selection (Magenta Box / White Text) */
    primary:        $ACCENT_PRI;
    on-primary:     $ACCENT_TXT;
    
    /* Secondary (Cyan) */
    secondary:      $ACCENT_SEC;
    on-secondary:   $BG;

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
theme[selected_fg]="$FG"
theme[inactive_fg]="$TEXT_DIM"
theme[graph_text]="$ACCENT_SEC"
theme[cpu_box]="$SURFACE"
theme[mem_box]="$SURFACE"
theme[net_box]="$SURFACE"
theme[proc_box]="$SURFACE"
theme[div_line]="$SURFACE_HIGH"
theme[cpu_start]="#7a00cc"
theme[cpu_end]="$ACCENT_PRI"
theme[mem_start]="#7a00cc"
theme[mem_end]="$ACCENT_PRI"
theme[net_start]="#7a00cc"
theme[net_end]="$ACCENT_PRI"
theme[download_start]="#7a00cc"
theme[download_end]="$ACCENT_PRI"
theme[upload_start]="#7a00cc"
theme[upload_end]="$ACCENT_PRI"
EOF

# ---------------------------------------------------------
# 5. CAVA & APPLY
# ---------------------------------------------------------
cat <<EOF > "$CAVA_CONF.tmp"
[color]
gradient = 1
gradient_count = 6
# Deep Purple -> Violet -> Pink -> Orange -> Yellow
gradient_color_1 = '#7a00cc'
gradient_color_2 = '#b300cc'
gradient_color_3 = '#ff007c'
gradient_color_4 = '#ff5e00'
gradient_color_5 = '#ffd700'
gradient_color_6 = '#ffffa0'

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
notify-send "Theme" "Synth Wave Applied."
