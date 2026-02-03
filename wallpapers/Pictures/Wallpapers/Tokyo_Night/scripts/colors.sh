#!/bin/bash

# -----------------------------------------------------------------------------
# THEME: Tokyo_Night (FIXED)
# DESCRIPTION: Deep Indigo Storm, Moonlit Text, Neon Cyan Accents.
# TYPE: Static Palette Injection
# -----------------------------------------------------------------------------

# --- PATHS ---
HYPR_CONF="$HOME/.config/hypr/colors.conf"
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
ROFI_CONF="$HOME/.config/rofi/colors.rasi"
BTOP_THEME="$HOME/.config/btop/themes/matugen.theme"
CAVA_CONF="$HOME/.config/cava/config"

# --- PALETTE VARIABLES (Raw Hex) ---
BG="#1a1b26"              # Storm (Midnight Blue)
FG="#c0caf5"              # Moonlight
SURFACE="#24283b"         # Storm Lighter
SURFACE_HIGH="#565f89"    # Fog Grey (Borders/Dim)

ACCENT_PRI="#7dcfff"      # Neon Cyan
ACCENT_TXT="#15161e"      # Dark Void (Text on Cyan)
ACCENT_SEC="#bb9af7"      # Twilight Purple

TEXT_DIM="#565f89"        # Fog Grey
BORDER_COL="#565f89"      # Fog Grey
ERROR_COL="#f7768e"       # Sakura Red

# ---------------------------------------------------------
# 1. HYPRLAND (colors.conf)
# ---------------------------------------------------------
cat <<EOF > "$HYPR_CONF.tmp"
# Tokyo_Night Hyprland Palette

# Core
\$background = rgba(1a1b26ff)
\$on_background = rgba(c0caf5ff)

# Surfaces
\$surface = rgba(24283bff)
\$surface_dim = rgba(1a1b26ff)
\$surface_container = rgba(24283bff)

# FIX: Define the variable causing the 'Red Bar' error
\$surface_container_high = rgba(565f89ff)

# Accents (Cyan + Purple Gradient)
# FIX: Ensure 8-digit Hex (RRGGBBAA)
\$primary = rgba(7dcfffff)
\$secondary = rgba(bb9af7ff)
\$inactive_border = rgba(565f89ff)

# Text
\$on_surface = rgba(c0caf5ff)
\$on_primary = rgba(15161eff)
EOF

# ---------------------------------------------------------
# 2. KITTY (current-theme.conf)
# ---------------------------------------------------------
cat <<EOF > "$KITTY_CONF.tmp"
# Tokyo_Night Kitty Theme
background            $BG
foreground            $FG
cursor                $FG
selection_background  #33467c
selection_foreground  $FG
url_color             #73daca

active_border_color   $ACCENT_PRI
inactive_border_color $SURFACE_HIGH
active_tab_background $ACCENT_PRI
active_tab_foreground $ACCENT_TXT
inactive_tab_background $SURFACE
inactive_tab_foreground $FG

# ANSI Palette (Official Tokyo Night)
color0  #15161e
color8  #414868
color1  #f7768e
color9  #f7768e
color2  #9ece6a
color10 #9ece6a
color3  #e0af68
color11 #e0af68
color4  #7aa2f7
color12 #7aa2f7
color5  #bb9af7
color13 #bb9af7
color6  #7dcfff
color14 #7dcfff
color7  #a9b1d6
color15 #c0caf5
EOF

# ---------------------------------------------------------
# 3. ROFI (colors.rasi) - FLAT DEFINITIONS
# ---------------------------------------------------------
cat <<EOF > "$ROFI_CONF.tmp"
* {
    /* Tokyo_Night Rofi Palette */

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
    
    /* Secondary (Purple) */
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
theme[graph_text]="#9ece6a"
theme[cpu_box]="$SURFACE"
theme[mem_box]="$SURFACE"
theme[net_box]="$SURFACE"
theme[proc_box]="$SURFACE"
theme[div_line]="$SURFACE_HIGH"
theme[cpu_start]="#7aa2f7"
theme[cpu_end]="#f7768e"
theme[mem_start]="#7aa2f7"
theme[mem_end]="#f7768e"
theme[net_start]="#7aa2f7"
theme[net_end]="#f7768e"
theme[download_start]="#7aa2f7"
theme[download_end]="#f7768e"
theme[upload_start]="#7aa2f7"
theme[upload_end]="#f7768e"
EOF

# ---------------------------------------------------------
# 5. CAVA & APPLY
# ---------------------------------------------------------
cat <<EOF > "$CAVA_CONF.tmp"
[color]
gradient = 1
gradient_count = 6
# Indigo -> Blue -> Cyan -> Teal
gradient_color_1 = '#7aa2f7'
gradient_color_2 = '#7dcfff'
gradient_color_3 = '#bb9af7'
gradient_color_4 = '#2ac3de'
gradient_color_5 = '#73daca'
gradient_color_6 = '#9ece6a'

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
