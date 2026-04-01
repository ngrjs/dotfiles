# dotfiles

i3wm setup with Catppuccin Mocha theming on Ubuntu 24.04.

## What's included

- **i3wm** — tiling window manager with gaps, vim-style keybindings
- **i3status-rust** — status bar with system vitals (CPU, GPU, memory, disk, battery, network)
- **picom** — compositor (shadows, blur, fading, rounded corners, transparency)
- **rofi** — app launcher, window switcher, clipboard manager, power menu
- **dunst** — notifications with volume/brightness OSD progress bars
- **wezterm** — terminal emulator with tmux-style pane splits
- **neovim** — LazyVim with Catppuccin Mocha, Rust LSP
- **zed** — editor with Catppuccin Mocha
- **yazi** — terminal file manager
- **autorandr** — automatic display profile switching
- **mise** — tool version manager (python, node, go, rust, pnpm, uv, etc.)
- **zsh** — oh-my-zsh with syntax highlighting, autosuggestions, fzf, fzf-tab
- **zoxide** — smarter cd
- **atuin** — shell history search

## Fresh install

### 1. Clone

```sh
git clone https://github.com/<your-username>/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Install system packages

```sh
sudo apt install i3 picom rofi dunst feh flameshot autorandr brightnessctl playerctl \
  thunar xss-lock lxpolkit network-manager-gnome papirus-icon-theme pipewire wireplumber \
  neovim fzf stow zsh
```

### 3. Install NVIDIA driver (if applicable)

```sh
sudo apt install nvidia-driver-580-open
sudo reboot
```

### 4. Install from source / GitHub releases

```sh
# i3status-rust
sudo apt install libsensors-dev libpulse-dev libssl-dev cargo
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

### 5. Install mise and tools

```sh
curl https://mise.run | sh
eval "$(~/.local/bin/mise activate zsh)"
mise install
```

This installs: python, node, go, rust, pnpm, uv, shellcheck, shfmt, btop.

### 6. Install fonts and themes

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
```

### 7. Install zsh plugins

```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/Aloxaf/fzf-tab ~/.oh-my-zsh/custom/plugins/fzf-tab
```

### 8. Deploy dotfiles

```sh
cd ~/dotfiles
stow config
stow zsh
```

### 9. Setup

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

### 10. Log out, select i3 from the login screen, log in.

First nvim launch will auto-install all plugins.

## Key bindings

### i3

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
| `$mod+Shift+c` | Reload config |
| `$mod+Shift+r` | Restart i3 |

### WezTerm (leader: Ctrl+b)

| Key | Action |
|-----|--------|
| `Ctrl+b` then `\|` | Split vertical |
| `Ctrl+b` then `-` | Split horizontal |
| `Ctrl+b` then `h/j/k/l` | Navigate panes |
| `Ctrl+b` then `z` | Zoom pane |
| `Ctrl+b` then `x` | Close pane |
| `Ctrl+b` then `c` | New tab |
| `Ctrl+b` then `n/p` | Next/prev tab |

### Shell

| Key | Action |
|-----|--------|
| `Ctrl+R` | Fuzzy search history (fzf) |
| `Ctrl+T` | Fuzzy find files |
| `Alt+C` | Fuzzy cd into directory |
| `Tab` | fzf-tab completion |
