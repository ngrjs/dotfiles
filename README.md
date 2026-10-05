# dotfiles

niri + DankMaterialShell setup on EndeavourOS.

## What's included

- **niri** — scrollable-tiling Wayland compositor (`config.kdl` only; see below)
- **ghostty** — terminal, with tmux-style splits on a `Ctrl+s` leader
- **neovim** — LazyVim with Catppuccin Mocha, Rust LSP
- **zed** — editor with Catppuccin Mocha
- **yazi** — terminal file manager
- **mise** — tool version manager (python, node, go, rust, pnpm, uv, etc.), configured via `mise.toml` at the repo root
- **zsh** — oh-my-zsh with syntax highlighting, autosuggestions, fzf, fzf-tab
- **zoxide** — smarter cd
- **atuin** — shell history search
- **git** — per-folder identity: work email by default, personal email for `~/dotfiles`
- **claude** — Claude Code settings and status line script (model, dir, git, plan usage bars)

DankMaterialShell (`dms`) provides the bar, launcher, notifications, clipboard, lock screen and
wallpaper-based theming. It generates `~/.config/niri/dms/*.kdl` (including keybinds),
`~/.config/ghostty/themes/dankcolors` and the GTK colors itself, so those are not tracked here.

## Fresh install

Assumes EndeavourOS with niri + DankMaterialShell already selected in the installer.

### 1. Clone

```sh
git clone https://github.com/<your-username>/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

The repo is expected at `~/dotfiles` — `.zshrc` points `MISE_GLOBAL_CONFIG_FILE` there.

### 2. Install packages

```sh
sudo pacman -S --needed stow zsh neovim mise zoxide atuin fzf ripgrep fd btop ttf-firacode-nerd
```

### 3. Install oh-my-zsh and plugins

```sh
git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/Aloxaf/fzf-tab ~/.oh-my-zsh/custom/plugins/fzf-tab
chsh -s /usr/bin/zsh
```

### 4. Deploy dotfiles

niri/ghostty/zed already have default configs from the installer; move them aside first so
stow can link over them:

```sh
mv ~/.config/niri/config.kdl{,.bak}
mv ~/.config/ghostty/config{,.bak}
mv ~/.config/zed/settings.json{,.bak}
stow config
stow zsh
stow git
stow claude
```

### 5. Install mise tools

```sh
export MISE_GLOBAL_CONFIG_FILE="$HOME/dotfiles/mise.toml"
mise install
```

This installs: python, node, go, rust, pnpm, uv, shellcheck, shfmt, btop, yazi.

### 6. Setup

```sh
# git identity — kept out of the repo; work email is the default, personal for ~/dotfiles
mkdir -p ~/.config/git-identity
printf '[user]\n\temail = you@work.com\n' > ~/.config/git-identity/default
printf '[user]\n\temail = you@personal.com\n' > ~/.config/git-identity/personal

# ssh-agent socket used by .zshrc
systemctl --user enable --now ssh-agent.socket
```

Log out and back in (for the shell change). First nvim launch will auto-install all plugins.

## Key bindings

### niri (from DMS defaults — `Mod+Shift+/` shows the full list)

| Key | Action |
|-----|--------|
| `Mod+T` | Terminal (Ghostty) |
| `Mod+Space` | App launcher |
| `Mod+Tab` / `Mod+O` | Overview |
| `Mod+V` | Clipboard history |
| `Mod+N` | Notification center |
| `Mod+Comma` | DMS settings |
| `Mod+Y` | Wallpapers |
| `Mod+Alt+L` | Lock screen |
| `Super+X` | Power menu |
| `Mod+Shift+E` | Quit niri |

### Ghostty (leader: Ctrl+s)

| Key | Action |
|-----|--------|
| `Ctrl+s` then `\|` | Split right |
| `Ctrl+s` then `-` | Split down |
| `Ctrl+s` then `h/j/k/l` | Navigate splits |
| `Ctrl+s` then `z` | Zoom split |
| `Ctrl+s` then `x` | Close split |
| `Ctrl+s` then `c` | New tab |
| `Ctrl+s` then `n/p` | Next/prev tab |

### Shell

| Key | Action |
|-----|--------|
| `Ctrl+R` | Fuzzy search history (atuin) |
| `Ctrl+T` | Fuzzy find files |
| `Alt+C` | Fuzzy cd into directory |
| `Tab` | fzf-tab completion |
