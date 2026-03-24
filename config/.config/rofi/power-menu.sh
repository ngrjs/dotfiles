#!/bin/sh
OPTIONS="  Lock\n  Logout\n  Suspend\n  Reboot\n  Shutdown"
CHOSEN=$(echo "$OPTIONS" | rofi -dmenu -i -p "Power" -theme ~/.config/rofi/catppuccin-mocha.rasi)

case "$CHOSEN" in
    *Lock)     i3lock-color --color 1e1e2e ;;
    *Logout)   i3-msg exit ;;
    *Suspend)  systemctl suspend ;;
    *Reboot)   systemctl reboot ;;
    *Shutdown) systemctl poweroff ;;
esac
