#!/bin/bash

# -----------------------------------------------------------------------------
# THEME: Rose_Pine
# DESCRIPTION: Deep Violet-Black, Soft Red/Rose, and Gold. (Organic Minimalism)
# TYPE: Static Palette Injection (Official Spec)
# -----------------------------------------------------------------------------

# --- PATHS ---
HYPR_CONF="$HOME/.config/hypr/colors.conf"
KITTY_CONF="$HOME/.config/kitty/current-theme.conf"
ROFI_CONF="$HOME/.config/rofi/colors.rasi"
BTOP_THEME="$HOME/.config/btop/themes/matugen.theme"
CAVA_CONF="$HOME/.config/cava/config"

# --- PALETTE VARIABLES (Raw Hex) ---
BG="#191724"              # Deep Violet-Black
FG="#e0def4"              # Soft Warm White
SURFACE="#26233a"         # Overlay
SURFACE_HIGH="#6e6a86"    # Muted Grey/Purple (Borders/Dim)

ACCENT_PRI="#eb6f92"      # Love (Dusty Red/Pink)
ACCENT_TXT="#191724"      # Base (Dark Text on Love)
ACCENT_SEC="#f6c177"      # Gold

TEXT_DIM="#6e6a86"        # Muted Grey/Purple
BORDER_COL="#6e6a86"      # Muted Grey/Purple
ERROR_COL="#eb6f92"       # Love

# ---------------------------------------------------------
# 1. HYPRLAND (colors.conf)
# ---------------------------------------------------------
cat <<EOF > "$HYPR_CONF.tmp"
# Rose_Pine Hyprland Palette

# Core
\$background = rgba(191724ff)
\$on_background = rgba(e0def4ff)

# Surfaces
\$surface = rgba(26233aff)
\$surface_dim = rgba(191724ff)
\$surface_container = rgba(26233aff)

# FIX: Define the variable causing the 'Red Bar' error
\$surface_container_high = rgba(6e6a86ff)

# Accents (Love + Gold Gradient)
\$primary = rgba(eb6f92ff)
\$secondary = rgba(f6c177ff)
\$inactive_border = rgba(6e6a86ff)

# Text
\$on_surface = rgba(e0def4ff)
\$on_primary = rgba(191724ff)
EOF

# ---------------------------------------------------------
# 2. KITTY (current-theme.conf)
# ---------------------------------------------------------
cat <<EOF > "$KITTY_CONF.tmp"
# Rose_Pine Kitty Theme
background            $BG
foreground            $FG
cursor                $ACCENT_PRI
selection_background  $SURFACE
selection_foreground  $FG
url_color             #c4a7e7

active_border_color   $ACCENT_PRI
inactive_border_color $SURFACE_HIGH
active_tab_background $ACCENT_PRI
active_tab_foreground $ACCENT_TXT
inactive_tab_background $SURFACE
inactive_tab_foreground $FG

# ANSI Palette (Official Rosé Pine)
color0  #26233a
color8  #6e6a86
color1  #eb6f92
color9  #eb6f92
color2  #31748f
color10 #31748f
color3  #f6c177
color11 #f6c177
color4  #9ccfd8
color12 #9ccfd8
color5  #c4a7e7
color13 #c4a7e7
color6  #ebbcba
color14 #ebbcba
color7  #e0def4
color15 #e0def4
EOF

# ---------------------------------------------------------
# 3. ROFI (colors.rasi) - FLAT DEFINITIONS
# ---------------------------------------------------------
cat <<EOF > "$ROFI_CONF.tmp"
* {
    /* Rose_Pine Rofi Palette */

    /* Backgrounds */
    background:     $BG;
    surface:        $SURFACE;
    
    /* Text */
    on-background:  $FG;
    on-surface:     $FG;
    text-dim:       $TEXT_DIM;

    /* Primary Selection (Love Box / Dark Text) */
    primary:        $ACCENT_PRI;
    on-primary:     $ACCENT_TXT;
    
    /* Secondary (Gold) */
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
theme[graph_text]="#9ccfd8"
theme[cpu_box]="$SURFACE"
theme[mem_box]="$SURFACE"
theme[net_box]="$SURFACE"
theme[proc_box]="$SURFACE"
theme[div_line]="$SURFACE_HIGH"
theme[cpu_start]="#31748f"
theme[cpu_end]="$ACCENT_PRI"
theme[mem_start]="#31748f"
theme[mem_end]="$ACCENT_PRI"
theme[net_start]="#31748f"
theme[net_end]="$ACCENT_PRI"
theme[download_start]="#31748f"
theme[download_end]="$ACCENT_PRI"
theme[upload_start]="#31748f"
theme[upload_end]="$ACCENT_PRI"
EOF

# ---------------------------------------------------------
# 5. CAVA & APPLY
# ---------------------------------------------------------
cat <<EOF > "$CAVA_CONF.tmp"
[color]
gradient = 1
gradient_count = 6
# Foam -> Iris -> Love -> Gold
gradient_color_1 = '#9ccfd8'
gradient_color_2 = '#c4a7e7'
gradient_color_3 = '#ebbcba'
gradient_color_4 = '#eb6f92'
gradient_color_5 = '#f6c177'
gradient_color_6 = '#f6c177'

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
notify-send "Theme" "Rose Pine Applied."
