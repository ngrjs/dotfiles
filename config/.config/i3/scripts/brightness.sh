#!/bin/sh
case "$1" in
    up)   brightnessctl set +5% ;;
    down) brightnessctl set 5%- ;;
esac
BRIGHTNESS=$(brightnessctl -m | awk -F, '{print substr($4, 0, length($4)-1)}')
dunstify -a "brightness" -h string:x-canonical-private-synchronous:brightness \
    -h int:value:"$BRIGHTNESS" -u low "Brightness: ${BRIGHTNESS}%"
