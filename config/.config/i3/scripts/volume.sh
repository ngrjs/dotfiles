#!/bin/sh
case "$1" in
    up)   wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ ;;
    down) wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
    mute) wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
esac
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%.0f", $2 * 100}')
MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -c MUTED)
if [ "$MUTED" -eq 1 ]; then
    dunstify -a "volume" -h string:x-canonical-private-synchronous:volume \
        -h int:value:"$VOLUME" -u low "Volume: Muted"
else
    dunstify -a "volume" -h string:x-canonical-private-synchronous:volume \
        -h int:value:"$VOLUME" -u low "Volume: ${VOLUME}%"
fi
