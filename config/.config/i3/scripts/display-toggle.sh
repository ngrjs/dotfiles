#!/bin/sh
LID=$(cat /proc/acpi/button/lid/*/state 2>/dev/null | awk '{print $2}')

if [ "$LID" = "closed" ]; then
    dunstify -a "display" -h string:x-canonical-private-synchronous:display -u low "Display: lid closed"
    exit 0
fi

HDMI=$(xrandr | grep "HDMI-1 connected")

if [ -n "$HDMI" ]; then
    CURRENT=$(autorandr --current 2>/dev/null)
    if [ "$CURRENT" = "docked" ]; then
        autorandr --load mobile
        dunstify -a "display" -h string:x-canonical-private-synchronous:display -u low "Display: mobile"
    else
        autorandr --load docked
        dunstify -a "display" -h string:x-canonical-private-synchronous:display -u low "Display: docked"
    fi
else
    autorandr --load mobile
    dunstify -a "display" -h string:x-canonical-private-synchronous:display -u low "Display: mobile (no HDMI)"
fi
