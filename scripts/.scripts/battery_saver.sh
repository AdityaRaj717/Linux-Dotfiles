#!/bin/bash

# Check if blur is currently enabled (1 = enabled, 0 = disabled)
IS_BLUR_ENABLED=$(hyprctl getoption decoration:blur:enabled -j | jq '.int')

if [ "$IS_BLUR_ENABLED" = "1" ]; then
    # TURN ON BATTERY SAVER
    # - Disable Blur, Shadows, Animations
    # - Set Rounding to 0 (Square corners)
    # - Set Opacity to 1.0 (No transparency)
    hyprctl --batch "\
        keyword decoration:blur:enabled false;\
        keyword decoration:drop_shadow false;\
        keyword animations:enabled false;\
        keyword decoration:rounding 0;\
        keyword decoration:active_opacity 1.0;\
        keyword decoration:inactive_opacity 1.0"
    
    notify-send -u normal -t 2000 "Battery Saver" "ON 🔋 (Effects OFF)"
else
    # TURN OFF BATTERY SAVER (Reload Config)
    # This restores your rounding (12), opacity (0.88), and animations automatically.
    hyprctl reload
    
    notify-send -u normal -t 2000 "Battery Saver" "OFF ⚡ (Visuals Restored)"
fi
