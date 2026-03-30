#!/bin/sh
# Toggle between laptop screen and external monitor (HDMI-1)

HDMI=$(xrandr | grep "HDMI-1 connected")
LAPTOP_ACTIVE=$(xrandr | grep "eDP-1" | grep -c "[0-9]x[0-9].*+[0-9]")

if [ -z "$HDMI" ]; then
    # No HDMI connected, use laptop
    xrandr --output eDP-1 --auto --primary --output HDMI-1 --off --output DP-1 --off
    dunstify -a "display" -h string:x-canonical-private-synchronous:display -u low "Display: laptop"
elif [ "$LAPTOP_ACTIVE" -eq 1 ]; then
    # Laptop is active, switch to HDMI
    xrandr --output HDMI-1 --auto --primary --output eDP-1 --off
    dunstify -a "display" -h string:x-canonical-private-synchronous:display -u low "Display: external (HDMI)"
else
    # HDMI is active, switch to laptop
    xrandr --output eDP-1 --auto --primary --output HDMI-1 --off
    dunstify -a "display" -h string:x-canonical-private-synchronous:display -u low "Display: laptop"
fi

# Re-apply wallpaper
feh --bg-fill ~/Pictures/wallpaper.jpg 2>/dev/null
