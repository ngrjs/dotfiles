# Oh My Zsh (runs compinit itself)
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions fzf fzf-tab)
source $ZSH/oh-my-zsh.sh

export PATH="$HOME/.local/bin:$PATH"
export EDITOR='nvim'
export TERMINAL='ghostty'
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

alias vim='nvim'

# mise — global tool list lives in the dotfiles repo, not ~/.config/mise
export MISE_GLOBAL_CONFIG_FILE="$HOME/dotfiles/mise.toml"
eval "$(mise activate zsh)"
eval "$(mise completion zsh)"

eval "$(zoxide init zsh)"
eval "$(atuin init zsh)"
