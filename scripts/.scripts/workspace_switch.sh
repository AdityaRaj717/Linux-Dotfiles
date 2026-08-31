#!/usr/bin/env bash
# =============================================================================
# Per-Monitor Workspace Switcher for Hyprland
# =============================================================================
# Usage:
#   workspace_switch.sh <1-10>              → Switch to workspace N on active monitor
#   workspace_switch.sh --move <1-10>       → Move window to workspace N on active monitor
#   workspace_switch.sh --move-silent <1-10>→ Move window silently to workspace N
# =============================================================================

# Monitor → workspace offset mapping
# HDMI-A-1 (external): workspaces 1-10  (offset = 0)
# eDP-1    (laptop)  : workspaces 11-20 (offset = 10)
SECONDARY_MONITOR="eDP-1"
OFFSET=10

# Get the currently focused monitor and current workspace
FOCUSED_MONITOR=$(hyprctl activeworkspace -j | jq -r '.monitor')
CURRENT_WS=$(hyprctl activeworkspace -j | jq -r '.id')

# Calculate base offset for current monitor
if [[ "$FOCUSED_MONITOR" == "$SECONDARY_MONITOR" ]]; then
    BASE=$OFFSET
else
    BASE=0
fi

# Parse arguments
ACTION="workspace"
case "$1" in
    --move)
        ACTION="movetoworkspace"
        shift
        ;;
    --move-silent)
        ACTION="movetoworkspacesilent"
        shift
        ;;
    --scroll-next)
        # Scroll to next workspace on this monitor (wrap 1-10 or 11-20)
        LOCAL_WS=$((CURRENT_WS - BASE))
        NEXT=$(( (LOCAL_WS % 10) + 1 + BASE ))
        hyprctl dispatch workspace "$NEXT"
        exit 0
        ;;
    --scroll-prev)
        # Scroll to previous workspace on this monitor (wrap 1-10 or 11-20)
        LOCAL_WS=$((CURRENT_WS - BASE))
        PREV=$(( ((LOCAL_WS - 2 + 10) % 10) + 1 + BASE ))
        hyprctl dispatch workspace "$PREV"
        exit 0
        ;;
esac

WS_NUM="$1"

if [[ -z "$WS_NUM" ]]; then
    echo "Usage: $0 [--move|--move-silent|--scroll-next|--scroll-prev] <workspace_number>"
    exit 1
fi

# Calculate the real workspace ID
REAL_WS=$((WS_NUM + BASE))

hyprctl dispatch "$ACTION" "$REAL_WS"
