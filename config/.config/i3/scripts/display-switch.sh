#!/bin/sh
# Rofi-based display switcher

LAPTOP=$(xrandr | grep -E "^eDP" | grep " connected" | awk '{print $1}')
HDMI=$(xrandr | grep -E "^HDMI" | grep " connected" | awk '{print $1}')
DP=$(xrandr | grep -E "^DP" | grep " connected" | awk '{print $1}')

# Build options based on connected displays
OPTIONS=""
[ -n "$LAPTOP" ] && OPTIONS="${OPTIONS}  Laptop ($LAPTOP)\n"
[ -n "$HDMI" ] && OPTIONS="${OPTIONS}  HDMI ($HDMI)\n"
[ -n "$DP" ] && OPTIONS="${OPTIONS}  DisplayPort ($DP)\n"
[ -n "$HDMI" ] && [ -n "$LAPTOP" ] && OPTIONS="${OPTIONS}  HDMI + Laptop\n"
[ -n "$DP" ] && [ -n "$LAPTOP" ] && OPTIONS="${OPTIONS}  DP + Laptop\n"

CHOSEN=$(echo "$OPTIONS" | rofi -dmenu -i -p "Display" -theme ~/.config/rofi/catppuccin-mocha.rasi)

case "$CHOSEN" in
    *"HDMI + Laptop"*)
        xrandr --output "$HDMI" --auto --primary --output "$LAPTOP" --auto --right-of "$HDMI"
        [ -n "$DP" ] && xrandr --output "$DP" --off
        dunstify -a "display" -h string:x-canonical-private-synchronous:display -u low "Display: HDMI + Laptop"
        ;;
    *"DP + Laptop"*)
        xrandr --output "$DP" --auto --primary --output "$LAPTOP" --auto --right-of "$DP"
        [ -n "$HDMI" ] && xrandr --output "$HDMI" --off
        dunstify -a "display" -h string:x-canonical-private-synchronous:display -u low "Display: DP + Laptop"
        ;;
    *Laptop*)
        [ -n "$HDMI" ] && xrandr --output "$HDMI" --off
        [ -n "$DP" ] && xrandr --output "$DP" --off
        xrandr --output "$LAPTOP" --auto --primary
        dunstify -a "display" -h string:x-canonical-private-synchronous:display -u low "Display: Laptop"
        ;;
    *HDMI*)
        xrandr --output "$HDMI" --auto --primary --output "$LAPTOP" --off
        [ -n "$DP" ] && xrandr --output "$DP" --off
        dunstify -a "display" -h string:x-canonical-private-synchronous:display -u low "Display: HDMI"
        ;;
    *DisplayPort*)
        xrandr --output "$DP" --auto --primary --output "$LAPTOP" --off
        [ -n "$HDMI" ] && xrandr --output "$HDMI" --off
        dunstify -a "display" -h string:x-canonical-private-synchronous:display -u low "Display: DisplayPort"
        ;;
esac

# Re-apply wallpaper
feh --bg-fill ~/Pictures/wallpaper.jpeg 2>/dev/null
