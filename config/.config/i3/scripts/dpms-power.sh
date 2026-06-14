#!/bin/sh
# Sets screensaver and DPMS timeouts based on AC power state.
# Plugged: 1 hour, Battery: 10 min.
# xss-lock listens to the X screensaver, so this also controls auto-lock.

apply() {
    if [ "$(cat /sys/class/power_supply/AC/online 2>/dev/null)" = "1" ]; then
        xset s 3600 +dpms dpms 3600 3600 3600
    else
        xset s 600 +dpms dpms 600 600 600
    fi
}

apply
prev=$(cat /sys/class/power_supply/AC/online 2>/dev/null)

while true; do
    sleep 30
    curr=$(cat /sys/class/power_supply/AC/online 2>/dev/null)
    if [ "$curr" != "$prev" ]; then
        apply
        prev="$curr"
    fi
done
