#!/bin/sh
/usr/local/bin/i3lock \
    --nofork \
    --color=1e1e2e \
    --inside-color=31324400 \
    --ring-color=b4befe \
    --insidever-color=89b4fa44 \
    --ringver-color=89b4fa \
    --insidewrong-color=f38ba844 \
    --ringwrong-color=f38ba8 \
    --line-color=00000000 \
    --keyhl-color=a6e3a1 \
    --bshl-color=f38ba8 \
    --separator-color=00000000 \
    --verif-color=cdd6f4 \
    --wrong-color=f38ba8 \
    --time-color=cdd6f4 \
    --date-color=a6adc8 \
    --layout-color=cdd6f4 \
    --clock \
    --indicator \
    --time-str="%H:%M" \
    --date-str="%a, %b %d" \
    --verif-text="Verifying..." \
    --wrong-text="Wrong!" \
    --noinput-text="No Input" \
    --radius=120 \
    --ring-width=8

# Re-detect displays after unlock (fixes HDMI wake issues)
xrandr --auto
autorandr --change
feh --bg-fill ~/Pictures/wallpaper.jpeg 2>/dev/null
