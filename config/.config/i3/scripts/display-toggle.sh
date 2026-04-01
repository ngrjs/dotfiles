#!/bin/sh
# Toggle between laptop screen and external monitor
# Auto-detects display names (handles HDMI-1, HDMI-1-1, etc.)

LAPTOP=$(xrandr | grep -E "^eDP" | grep " connected" | awk '{print $1}')
HDMI=$(xrandr | grep -E "^HDMI" | grep " connected" | awk '{print $1}')
DP=$(xrandr | grep -E "^DP" | grep " connected" | awk '{print $1}')

# Check if laptop is currently active (has a resolution + offset)
LAPTOP_ACTIVE=$(xrandr | grep "^$LAPTOP" | grep -c "[0-9]x[0-9].*+[0-9]")

if [ -z "$HDMI" ] && [ -z "$DP" ]; then
    # No external connected, use laptop
    xrandr --output "$LAPTOP" --auto --primary
    dunstify -a "display" -h string:x-canonical-private-synchronous:display -u low "Display: laptop"
elif [ "$LAPTOP_ACTIVE" -eq 1 ]; then
    # Laptop is active, switch to external
    if [ -n "$HDMI" ]; then
        EXT="$HDMI"
    else
        EXT="$DP"
    fi
    xrandr --output "$EXT" --auto --primary --output "$LAPTOP" --off
    [ -n "$DP" ] && [ "$DP" != "$EXT" ] && xrandr --output "$DP" --off
    dunstify -a "display" -h string:x-canonical-private-synchronous:display -u low "Display: external ($EXT)"
else
    # External is active, switch to laptop
    xrandr --output "$LAPTOP" --auto --primary
    [ -n "$HDMI" ] && xrandr --output "$HDMI" --off
    [ -n "$DP" ] && xrandr --output "$DP" --off
    dunstify -a "display" -h string:x-canonical-private-synchronous:display -u low "Display: laptop"
fi

# Re-apply wallpaper
feh --bg-fill ~/Pictures/wallpaper.jpg 2>/dev/null
