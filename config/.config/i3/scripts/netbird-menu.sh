#!/usr/bin/env bash
# Rofi menu for NetBird management

theme=~/.config/rofi/catppuccin-mocha.rasi

options="Quick Actions\nProfiles\nSettings\nNetworks\n---\nConnect (up)\nDisconnect (down)\nStatus\nLogin"

choice=$(printf "%b" "$options" | rofi -dmenu -i -p "NetBird" -theme "$theme")

case "$choice" in
    "Quick Actions")    netbird-ui -quick-actions ;;
    "Profiles")         netbird-ui -profiles ;;
    "Settings")         netbird-ui -settings ;;
    "Networks")         netbird-ui -networks ;;
    "Connect (up)")     netbird up ;;
    "Disconnect (down)") netbird down ;;
    "Status")           notify-send "NetBird" "$(netbird status | head -15)" ;;
    "Login")            netbird login ;;
esac
