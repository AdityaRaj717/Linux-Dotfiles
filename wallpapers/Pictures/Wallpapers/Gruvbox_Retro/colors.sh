#!/bin/bash

# -----------------------------------------------------------------------------
# THEME: Gruvbox_Retro
# DESCRIPTION: Hard Contrast Dark Mode. Warm Charcoal, Cream, and Retro Orange.
# TYPE: Static Palette Injection (Vintage Terminal Style)
# -----------------------------------------------------------------------------

# --- PATHS ---
HYPR_CONF="$HOME/.config/hypr/colors.conf"
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
ROFI_CONF="$HOME/.config/rofi/colors.rasi"
BTOP_THEME="$HOME/.config/btop/themes/matugen.theme"
CAVA_CONF="$HOME/.config/cava/config"

# --- PALETTE VARIABLES (Raw Hex) ---
BG="#1d2021"              # Hard Dark Charcoal
FG="#ebdbb2"              # Cream
SURFACE="#3c3836"         # Dark Brown-Grey
SURFACE_HIGH="#504945"    # Muted Earth (Borders/Dim)

ACCENT_PRI="#fe8019"      # Retro Orange
ACCENT_TXT="#1d2021"      # Dark Text (High Contrast on Orange)
ACCENT_SEC="#fabd2f"      # Retro Yellow

TEXT_DIM="#928374"        # Gruvbox Grey (Readable Dim Text)
BORDER_COL="#504945"      # Muted Earth
ERROR_COL="#cc241d"       # Retro Red

# ---------------------------------------------------------
# 1. HYPRLAND (colors.conf)
# ---------------------------------------------------------
cat <<EOF > "$HYPR_CONF.tmp"
# Gruvbox_Retro Hyprland Palette

# Core
\$background = rgba(1d2021ff)
\$on_background = rgba(ebdbb2ff)

# Surfaces
\$surface = rgba(3c3836ff)
\$surface_dim = rgba(1d2021ff)
\$surface_container = rgba(3c3836ff)

# FIX: Define the variable causing the 'Red Bar' error
\$surface_container_high = rgba(504945ff)

# Accents (Orange + Yellow Gradient)
\$primary = rgba(fe8019ff)
\$secondary = rgba(fabd2fff)
\$inactive_border = rgba(504945ff)

# Text
\$on_surface = rgba(ebdbb2ff)
\$on_primary = rgba(1d2021ff)
EOF

# ---------------------------------------------------------
# 2. KITTY (current-theme.conf)
# ---------------------------------------------------------
cat <<EOF > "$KITTY_CONF.tmp"
# Gruvbox_Retro Kitty Theme
background            $BG
foreground            $FG
cursor                $ACCENT_PRI
selection_background  $SURFACE_HIGH
selection_foreground  $FG
url_color             #83a598

active_border_color   $ACCENT_PRI
inactive_border_color $SURFACE_HIGH
active_tab_background $ACCENT_PRI
active_tab_foreground $ACCENT_TXT
inactive_tab_background $SURFACE
inactive_tab_foreground $FG

# ANSI Palette (Official Gruvbox)
color0  #282828
color8  #928374
color1  #cc241d
color9  #fb4934
color2  #98971a
color10 #b8bb26
color3  #d79921
color11 #fabd2f
color4  #458588
color12 #83a598
color5  #b16286
color13 #d3869b
color6  #689d6a
color14 #8ec07c
color7  #a89984
color15 #ebdbb2
EOF

# ---------------------------------------------------------
# 3. ROFI (colors.rasi) - FLAT DEFINITIONS
# ---------------------------------------------------------
cat <<EOF > "$ROFI_CONF.tmp"
* {
    /* Gruvbox_Retro Rofi Palette */

    /* Backgrounds */
    background:     $BG;
    surface:        $SURFACE;
    
    /* Text */
    on-background:  $FG;
    on-surface:     $FG;
    text-dim:       $TEXT_DIM;

    /* Primary Selection (Orange Box / Dark Text) */
    primary:        $ACCENT_PRI;
    on-primary:     $ACCENT_TXT;
    
    /* Secondary (Yellow) */
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
theme[graph_text]="#d3869b"
theme[cpu_box]="$SURFACE"
theme[mem_box]="$SURFACE"
theme[net_box]="$SURFACE"
theme[proc_box]="$SURFACE"
theme[div_line]="$SURFACE_HIGH"
theme[cpu_start]="#fabd2f"
theme[cpu_end]="$ACCENT_PRI"
theme[mem_start]="#fabd2f"
theme[mem_end]="$ACCENT_PRI"
theme[net_start]="#fabd2f"
theme[net_end]="$ACCENT_PRI"
theme[download_start]="#fabd2f"
theme[download_end]="$ACCENT_PRI"
theme[upload_start]="#fabd2f"
theme[upload_end]="$ACCENT_PRI"
EOF

# ---------------------------------------------------------
# 5. CAVA & APPLY
# ---------------------------------------------------------
cat <<EOF > "$CAVA_CONF.tmp"
[color]
gradient = 1
gradient_count = 6
# Red -> Orange -> Yellow (Warm Heatmap)
gradient_color_1 = '#cc241d'
gradient_color_2 = '#fb4934'
gradient_color_3 = '#d79921'
gradient_color_4 = '#fe8019'
gradient_color_5 = '#fab387'
gradient_color_6 = '#ebdbb2'

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
notify-send "Theme" "Gruvbox Retro Applied."
