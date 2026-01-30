#!/bin/bash

# -----------------------------------------------------------------------------
# THEME: Abyssal_Wave
# DESCRIPTION: Deep Ocean Navy, Bioluminescent Teal, and Rusty Coral.
# TYPE: Static Palette Injection (Corrected for "Claude" Style Rofi)
# -----------------------------------------------------------------------------

# --- PATHS ---
HYPR_CONF="$HOME/.config/hypr/colors.conf"
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
ROFI_CONF="$HOME/.config/rofi/colors.rasi"
BTOP_THEME="$HOME/.config/btop/themes/matugen.theme"
CAVA_CONF="$HOME/.config/cava/config"

# --- PALETTE DEFINITIONS (Raw Hex) ---
BG="#0b121e"              # Deepest Navy
FG="#dce0e8"              # Glacial White
SURFACE="#161d2d"         # Lighter Navy (Panels)
SURFACE_HIGH="#2a3b55"    # Even Lighter (Borders/Inactive)
ACCENT_PRI="#ff8f70"      # Coral (Rust)
ACCENT_SEC="#4fd6be"      # Teal (Bioluminescent)
TEXT_DIM="#6b7a94"        # Muted Text
BORDER_COL="#2a3b55"      # Muted Border
ERROR_COL="#e06c75"       # Muted Red

# ---------------------------------------------------------
# 1. HYPRLAND (colors.conf)
# ---------------------------------------------------------
cat <<EOF > "$HYPR_CONF.tmp"
# Abyssal_Wave Hyprland Palette

# Core
\$background = rgba(0b121eff)
\$on_background = rgba(dce0e8ff)

# Surfaces
\$surface = rgba(161d2dff)
\$surface_dim = rgba(0b121eff)
\$surface_container = rgba(161d2dff)

# FIX: Explicitly define the variable causing the 'Red Bar' error
\$surface_container_high = rgba(2a3b55ff)

# Borders & Accents
\$primary = rgba(ff8f70ff)
\$secondary = rgba(4fd6beff)
\$inactive_border = rgba(2a3b55ff)

# Text
\$on_surface = rgba(dce0e8ff)
\$on_primary = rgba(0b121eff)
EOF

# ---------------------------------------------------------
# 2. KITTY (current-theme.conf)
# ---------------------------------------------------------
cat <<EOF > "$KITTY_CONF.tmp"
# Abyssal_Wave Kitty Theme
background            $BG
foreground            $FG
cursor                $ACCENT_PRI
selection_background  $SURFACE_HIGH
selection_foreground  $FG
url_color             $ACCENT_SEC
active_border_color   $ACCENT_PRI
inactive_border_color $SURFACE_HIGH
active_tab_background $ACCENT_PRI
active_tab_foreground $BG
inactive_tab_background $SURFACE
inactive_tab_foreground $FG

# ANSI Palette
color0  #121a2b
color8  #384b66
color1  #e06c75
color9  #ff8f70
color2  #98c379
color10 #4fd6be
color3  #e5c07b
color11 #f0d197
color4  #61afef
color12 #70bdff
color5  #c678dd
color13 #d68eff
color6  #56b6c2
color14 #75e0ea
color7  #abb2bf
color15 #ffffff
EOF

# ---------------------------------------------------------
# 3. ROFI (colors.rasi) - STRICT FLAT DEFINITIONS
# ---------------------------------------------------------
# We define variables with HEX LITERALS to avoid recursion.
cat <<EOF > "$ROFI_CONF.tmp"
* {
    /* Abyssal_Wave Rofi Palette */

    /* Core Colors */
    background:     $BG;
    surface:        $SURFACE;
    on-background:  $FG;
    on-surface:     $FG;
    
    /* Text Dimming (Critical for Placeholders) */
    text-dim:       $TEXT_DIM;

    /* Accents */
    primary:        $ACCENT_PRI;
    on-primary:     $BG;
    secondary:      $ACCENT_SEC;
    on-secondary:   $BG;

    /* Status / State */
    active:         $ACCENT_PRI;
    selected:       $ACCENT_PRI;
    urgent:         $ERROR_COL;
    error:          $ERROR_COL;
    on-error:       $FG;

    /* Borders & Separators */
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
theme[selected_bg]="$SURFACE_HIGH"
theme[selected_fg]="$FG"
theme[inactive_fg]="$TEXT_DIM"
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
# 5. CAVA & ATOMIC APPLY
# ---------------------------------------------------------
cat <<EOF > "$CAVA_CONF.tmp"
[color]
gradient = 1
gradient_count = 6
gradient_color_1 = '$BG'
gradient_color_2 = '$SURFACE'
gradient_color_3 = '#2d5b6b'
gradient_color_4 = '$ACCENT_SEC'
gradient_color_5 = '#f0d197'
gradient_color_6 = '$ACCENT_PRI'

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

# Reload Cava
pkill -USR1 cava || true

notify-send "Theme" "Abyssal Wave Applied."
