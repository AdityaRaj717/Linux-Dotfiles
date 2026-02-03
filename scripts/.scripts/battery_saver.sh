#!/bin/bash

# =======================================================================
# CONFIGURATION
# =======================================================================

# Check if battery saver is currently enabled (using the blur state as a flag)
IS_BATTERY_SAVER=$(hyprctl getoption decoration:blur:enabled -j | jq '.int')

if [ "$IS_BATTERY_SAVER" = "1" ]; then
    # =================================================================
    # TURN ON BATTERY SAVER
    # =================================================================
    
    # 1. GET MONITOR INFO (Name, Resolution, Scale)
    MONITOR_INFO=$(hyprctl monitors -j | jq '.[0]')
    NAME=$(echo "$MONITOR_INFO" | jq -r '.name')
    WIDTH=$(echo "$MONITOR_INFO" | jq -r '.width')
    HEIGHT=$(echo "$MONITOR_INFO" | jq -r '.height')
    SCALE=$(echo "$MONITOR_INFO" | jq -r '.scale')

    # 2. APPLY HYPRLAND OPTIMIZATIONS
    # - Disable Blur, Shadows, Animations
    # - Disable Rounding (0) & Transparency (1.0)
    # - Force 60Hz on the specific monitor 
    hyprctl --batch "\
        keyword decoration:blur:enabled false;\
        keyword decoration:drop_shadow false;\
        keyword animations:enabled false;\
        keyword decoration:rounding 0;\
        keyword decoration:active_opacity 1.0;\
        keyword decoration:inactive_opacity 1.0;\
        keyword misc:vfr true;\
        keyword monitor $NAME,${WIDTH}x${HEIGHT}@60,auto,$SCALE"

    # 3. SYSTEM POWER PROFILE (if available)
    if command -v powerprofilesctl &> /dev/null; then
        powerprofilesctl set power-saver
    fi

    notify-send -u normal -t 3000 "Battery Saver" "ON 🔋\n- ${WIDTH}x${HEIGHT}@60Hz\n- Effects Disabled"
else
    # =================================================================
    # TURN OFF BATTERY SAVER (Performance Mode)
    # =================================================================
    
    # 1. RELOAD HYPRLAND
    hyprctl reload
    
    # 2. RESTORE SYSTEM POWER PROFILE
    if command -v powerprofilesctl &> /dev/null; then
        powerprofilesctl set balanced
    fi

    notify-send -u normal -t 3000 "Battery Saver" "OFF ⚡\n- High Refresh Restored\n- Visuals Restored"
fi
