# dotfiles

i3wm setup with Catppuccin Mocha theming on Ubuntu 24.04.

## What's included

- **i3wm** — tiling window manager with gaps, vim-style keybindings
- **i3status-rust** — status bar with system vitals (CPU, memory, disk, battery, network)
- **picom** — compositor (shadows, fading, rounded corners, transparency)
- **rofi** — app launcher, window switcher, clipboard manager, power menu
- **dunst** — notifications with volume/brightness OSD progress bars
- **wezterm** — terminal emulator
- **yazi** — terminal file manager
- **autorandr** — automatic display profile switching
- **vim** — with catppuccin theme and vim-airline
- **zsh** — oh-my-zsh with syntax highlighting

## Fresh install

### 1. Clone

```sh
git clone https://github.com/<your-username>/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Install packages

```sh
sudo apt install i3 picom rofi dunst feh flameshot autorandr brightnessctl playerctl \
  thunar xss-lock lxpolkit network-manager-gnome papirus-icon-theme pipewire wireplumber \
  libsensors-dev libpulse-dev libssl-dev cargo stow zsh
```

### 3. Install from source / GitHub releases

```sh
# i3status-rust
cargo install i3status-rs
sudo mkdir -p /usr/share/i3status-rust/{themes,icons}
sudo cp ~/.cargo/registry/src/index.crates.io-*/i3status-rs-*/files/themes/* /usr/share/i3status-rust/themes/
sudo cp ~/.cargo/registry/src/index.crates.io-*/i3status-rs-*/files/icons/* /usr/share/i3status-rust/icons/

# i3lock-color
sudo apt install autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev \
  libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev \
  libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev libxkbcommon-dev \
  libxkbcommon-x11-dev libjpeg-dev
git clone https://github.com/Raymo111/i3lock-color.git /tmp/i3lock-color
cd /tmp/i3lock-color && ./install-i3lock-color.sh

# greenclip
mkdir -p ~/.local/bin
wget https://github.com/erebe/greenclip/releases/latest/download/greenclip -O ~/.local/bin/greenclip
chmod +x ~/.local/bin/greenclip

# yazi
wget -O /tmp/yazi.zip https://github.com/sxyazi/yazi/releases/latest/download/yazi-x86_64-unknown-linux-gnu.zip
unzip /tmp/yazi.zip -d /tmp/yazi
sudo mv /tmp/yazi/yazi-x86_64-unknown-linux-gnu/yazi /usr/local/bin/
sudo mv /tmp/yazi/yazi-x86_64-unknown-linux-gnu/ya /usr/local/bin/
```

### 4. Install fonts and themes

```sh
# FiraCode Nerd Font
wget -P /tmp https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
mkdir -p ~/.local/share/fonts
unzip /tmp/FiraCode.zip -d ~/.local/share/fonts/FiraCode
fc-cache -fv

# Catppuccin GTK theme
mkdir -p ~/.themes
wget -O /tmp/catppuccin-gtk.zip https://github.com/catppuccin/gtk/releases/latest/download/catppuccin-mocha-mauve-standard+default.zip
unzip /tmp/catppuccin-gtk.zip -d ~/.themes/

# Catppuccin cursors
mkdir -p ~/.icons
wget -O /tmp/catppuccin-cursors.zip https://github.com/catppuccin/cursors/releases/latest/download/catppuccin-mocha-dark-cursors.zip
unzip /tmp/catppuccin-cursors.zip -d ~/.icons/

# Zsh syntax highlighting
git clone https://github.com/catppuccin/zsh-syntax-highlighting.git \
  ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
```

### 5. Deploy dotfiles

```sh
cd ~/dotfiles
stow config
stow zsh
stow vim
```

### 6. Install vim plugins

```sh
vim +PlugInstall +qall
```

### 7. Setup

```sh
# Add user to video group (for brightness control)
sudo usermod -aG video $USER

# Place a wallpaper
mkdir -p ~/Pictures
cp /path/to/wallpaper.jpg ~/Pictures/wallpaper.jpg

# Save display profiles (run with external monitor connected)
autorandr --save docked
# Then disconnect monitor and run:
autorandr --save mobile

# Auto-switch displays on hotplug
echo 'ACTION=="change", SUBSYSTEM=="drm", RUN+="/usr/bin/autorandr --batch --change --default mobile"' \
  | sudo tee /etc/udev/rules.d/40-monitor-hotplug.rules
sudo udevadm control --reload-rules

# Prevent suspend when lid closed while docked
sudo sed -i 's/#HandleLidSwitchDocked=.*/HandleLidSwitchDocked=ignore/' /etc/systemd/logind.conf
sudo systemctl restart systemd-logind
```

### 8. Log out, select i3 from the login screen, log in.

## Key bindings

| Key | Action |
|-----|--------|
| `$mod+Return` | Terminal (WezTerm) |
| `$mod+d` | App launcher (Rofi) |
| `$mod+Tab` | Window switcher |
| `$mod+q` | Kill window |
| `$mod+h/j/k/l` | Focus left/down/up/right |
| `$mod+Shift+h/j/k/l` | Move window |
| `$mod+f` | Fullscreen |
| `$mod+v` | Clipboard history |
| `$mod+Shift+s` | Screenshot |
| `$mod+Shift+e` | Power menu |
| `$mod+Escape` | Lock screen |
| `$mod+r` | Resize mode |
| `$mod+1-9` | Switch workspace |
