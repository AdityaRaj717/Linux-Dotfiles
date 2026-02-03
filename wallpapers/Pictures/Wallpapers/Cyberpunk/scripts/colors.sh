#!/bin/bash

# -----------------------------------------------------------------------------
# THEME: Cyberpunk
# DESCRIPTION: Deep Void Black, Blinding Neon Yellow, and Electric Cyan.
# TYPE: Static Palette Injection (High Contrast / Edgerunner Style)
# -----------------------------------------------------------------------------

# --- PATHS ---
HYPR_CONF="$HOME/.config/hypr/colors.conf"
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
ROFI_CONF="$HOME/.config/rofi/colors.rasi"
BTOP_THEME="$HOME/.config/btop/themes/matugen.theme"
CAVA_CONF="$HOME/.config/cava/config"

# --- PALETTE VARIABLES (Raw Hex) ---
BG="#050510"              # The Void
FG="#ffffff"              # Pure White Text
SURFACE="#12121f"         # Dark Indigo-Grey
SURFACE_HIGH="#2a2a35"    # Muted Steel (Borders/Dim)

ACCENT_PRI="#fcee0a"      # Cyber Yellow (Primary)
ACCENT_TXT="#000000"      # Black (Text on Yellow - Critical)
ACCENT_SEC="#00f0ff"      # Electric Cyan (Secondary)

TEXT_DIM="#797986"        # Dimmed Text
BORDER_COL="#2a2a35"      # Inactive Border
ERROR_COL="#ff0055"       # Psycho Red

# ---------------------------------------------------------
# 1. HYPRLAND (colors.conf)
# ---------------------------------------------------------
cat <<EOF > "$HYPR_CONF.tmp"
# Cyberpunk Hyprland Palette

# Core
\$background = rgba(050510ff)
\$on_background = rgba(ffffffff)

# Surfaces
\$surface = rgba(12121fff)
\$surface_dim = rgba(050510ff)
\$surface_container = rgba(12121fff)

# FIX: Define the variable causing the 'Red Bar' error
\$surface_container_high = rgba(2a2a35ff)

# Accents (Yellow + Cyan Gradient)
\$primary = rgba(fcee0aff)
\$secondary = rgba(00f0ffff)
\$inactive_border = rgba(2a2a35ff)

# Text
\$on_surface = rgba(ffffffff)
\$on_primary = rgba(000000ff)
EOF

# ---------------------------------------------------------
# 2. KITTY (current-theme.conf)
# ---------------------------------------------------------
cat <<EOF > "$KITTY_CONF.tmp"
# Cyberpunk Kitty Theme
background            $BG
foreground            $FG
cursor                $ACCENT_SEC
selection_background  $ACCENT_PRI
selection_foreground  $ACCENT_TXT
url_color             $ACCENT_SEC

active_border_color   $ACCENT_PRI
inactive_border_color $SURFACE_HIGH
active_tab_background $ACCENT_PRI
active_tab_foreground $ACCENT_TXT
inactive_tab_background $SURFACE
inactive_tab_foreground $FG

# ANSI Palette (Night City Spectrum)
color0  #12121f
color8  #3a3a4a
color1  #ff0055
color9  #ff2a6d
color2  #39ff14
color10 #6aff4d
color3  #fcee0a
color11 #fff65c
color4  #00f0ff
color12 #66f7ff
color5  #bd00ff
color13 #d966ff
color6  #00f0ff
color14 #80faff
color7  #e0e0e0
color15 #ffffff
EOF

# ---------------------------------------------------------
# 3. ROFI (colors.rasi) - FLAT DEFINITIONS
# ---------------------------------------------------------
# Uses flat hex definitions for safety and visibility.
cat <<EOF > "$ROFI_CONF.tmp"
* {
    /* Cyberpunk Rofi Palette */

    /* Backgrounds */
    background:     $BG;
    surface:        $SURFACE;
    
    /* Text */
    on-background:  $FG;
    on-surface:     $FG;
    text-dim:       $TEXT_DIM;

    /* Primary Selection (Yellow Box / Black Text) */
    primary:        $ACCENT_PRI;
    on-primary:     $ACCENT_TXT;
    
    /* Secondary (Cyan) */
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
theme[graph_text]="$ACCENT_SEC"
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
# Cyan -> Neon Green -> Yellow -> Psycho Red
gradient_color_1 = '#00f0ff'
gradient_color_2 = '#00ff9f'
gradient_color_3 = '#fcee0a'
gradient_color_4 = '#ff9900'
gradient_color_5 = '#ff2a6d'
gradient_color_6 = '#ff0055'

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
