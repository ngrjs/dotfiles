# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions fzf)
source $ZSH/oh-my-zsh.sh

# Completion
autoload -Uz compinit
compinit

# PATH
export PATH="$HOME/.local/bin:$PATH"

# Editor
export EDITOR='nvim'
alias vim='nvim'

# Terminal
export TERMINAL='wezterm'

# Cursor
export XCURSOR_THEME='catppuccin-mocha-dark-cursors'
export XCURSOR_SIZE=24

# mise (python, node, etc version management)
eval "$(mise activate zsh)"

# zoxide (smarter cd)
eval "$(zoxide init zsh)"

# Atuin shell history
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"
