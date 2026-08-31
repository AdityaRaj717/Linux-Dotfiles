#!/bin/bash

# =============================================================================
# Monitor Mode Switcher
# Switches between Single (laptop only) and Dual (laptop + HDMI) monitor setups.
# Rewrites ~/.config/hypr/conf/monitors.conf and reloads Hyprland.
# =============================================================================

MONITORS_CONF="$HOME/.config/hypr/conf/monitors.conf"
CACHE_FILE="$HOME/.cache/monitor_mode"
ROFI_THEME="$HOME/.config/rofi/monitor-switch.rasi"

# --- Detect current mode ---
CURRENT_MODE="dual"
[ -f "$CACHE_FILE" ] && CURRENT_MODE=$(cat "$CACHE_FILE")

# --- Build rofi menu ---
OPTION_SINGLE="󰍺  Single Monitor  (Laptop Only)"
OPTION_DUAL="󰍹  Dual Monitor  (Laptop + HDMI)"

if [ "$CURRENT_MODE" = "single" ]; then
    MENU_INPUT="${OPTION_SINGLE} ✓\n${OPTION_DUAL}"
else
    MENU_INPUT="${OPTION_SINGLE}\n${OPTION_DUAL} ✓"
fi

SELECTED=$(echo -e "$MENU_INPUT" | rofi -dmenu -theme "$ROFI_THEME" -p "Monitor Mode")
[ -z "$SELECTED" ] && exit 0

# --- Apply selected mode ---

write_single_monitor() {
    cat > "$MONITORS_CONF" << 'EOF'
################
### MONITORS ###
################

# Single Monitor Mode (Laptop Only)
monitor=eDP-1,2560x1600@165.0,0x0,1.67
monitor=HDMI-A-1,disabled

# All workspaces on laptop screen
workspace=1,monitor:eDP-1,default:true
workspace=2,monitor:eDP-1
workspace=3,monitor:eDP-1
workspace=4,monitor:eDP-1
workspace=5,monitor:eDP-1
workspace=6,monitor:eDP-1
workspace=7,monitor:eDP-1
workspace=8,monitor:eDP-1
workspace=9,monitor:eDP-1
workspace=10,monitor:eDP-1

# For HDR
# Syntax: monitor = NAME, RESOLUTION@HZ, POS, SCALE, bitdepth, 10, cm, hdr, sdrbrightness, 1.2
# monitor =, highres@highrr, auto, 1.25, bitdepth, 10, cm, hdr, sdrbrightness, 1.5
EOF
    echo "single" > "$CACHE_FILE"
}

write_dual_monitor() {
    cat > "$MONITORS_CONF" << 'EOF'
################
### MONITORS ###
################

# Dual Monitor Mode (Laptop + HDMI)
monitor=HDMI-A-1,1920x1080@120.0,1600x0,1.0,bitdepth,10
monitor=eDP-1,2560x1600@165.0,0x80,1.67

# Dual monitor setup, dgpu — odd workspaces on laptop, even on HDMI
workspace=1,monitor:eDP-1,default:true
workspace=2,monitor:HDMI-A-1,default:true
workspace=3,monitor:eDP-1
workspace=4,monitor:HDMI-A-1
workspace=5,monitor:eDP-1
workspace=6,monitor:HDMI-A-1
workspace=7,monitor:eDP-1
workspace=8,monitor:HDMI-A-1
workspace=9,monitor:eDP-1
workspace=10,monitor:HDMI-A-1

# For HDR
# Syntax: monitor = NAME, RESOLUTION@HZ, POS, SCALE, bitdepth, 10, cm, hdr, sdrbrightness, 1.2
# monitor =, highres@highrr, auto, 1.25, bitdepth, 10, cm, hdr, sdrbrightness, 1.5
EOF
    echo "dual" > "$CACHE_FILE"
}

case "$SELECTED" in
    *"Single Monitor"*)
        write_single_monitor
        hyprctl reload
        notify-send "Monitor Mode" "Switched to Single Monitor (Laptop Only) 󰍺" -t 3000
        ;;
    *"Dual Monitor"*)
        write_dual_monitor
        hyprctl reload
        notify-send "Monitor Mode" "Switched to Dual Monitor (Laptop + HDMI) 󰍹" -t 3000
        ;;
esac
