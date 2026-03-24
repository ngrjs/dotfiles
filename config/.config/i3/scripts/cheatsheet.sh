#!/bin/sh
cat << 'EOF' | rofi -dmenu -i -p "i3 Cheatsheet" -theme ~/.config/rofi/catppuccin-mocha.rasi
--- Essentials ---
Super+Return        Terminal (wezterm)
Super+q             Close window
Super+d             App launcher (rofi)
Super+Shift+c       Reload config
Super+Shift+r       Restart i3
--- Navigation ---
Super+h/j/k/l       Focus left/down/up/right
Super+Shift+h/j/k/l Move window
Super+f              Fullscreen toggle
Super+Space          Toggle focus tiling/floating
Super+Shift+Space    Toggle floating
--- Layouts ---
Super+s             Stacking
Super+w             Tabbed
Super+e             Toggle split
Super+r             Resize mode (h/j/k/l, Esc)
--- Workspaces ---
Super+1-9           Switch workspace
Super+Shift+1-9     Move window to workspace
--- Tools ---
Super+Tab           Window switcher
Super+v             Clipboard history
Super+n             File manager (thunar)
Super+b             Toggle bar
Super+Shift+s       Screenshot (region)
Print               Screenshot (full)
Super+p             Toggle display (docked/mobile)
Super+/             This cheatsheet
Super+Escape        Lock screen
Super+Shift+e       Power menu
--- Media ---
Volume keys         Volume up/down/mute
Brightness keys     Brightness up/down
Play/Next/Prev      Media controls
EOF
