# ===================
# Oh My Zsh
# ===================
export ZSH="$HOME/.oh-my-zsh"

# Theme (comment out if using Starship)
# ZSH_THEME="robbyrussell"

# Plugins
plugins=(
    git
    docker
    docker-compose
    kubectl
    npm
    node
    python
    golang
    brew
    macos
    z
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ===================
# Homebrew
# ===================
eval "$(/opt/homebrew/bin/brew shellenv)"

# ===================
# Starship Prompt
# ===================
eval "$(starship init zsh)"

# ===================
# fnm (Node.js)
# ===================
eval "$(fnm env --use-on-cd)"

# ===================
# Go
# ===================
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
eval "$(goenv init -)"

# ===================
# pnpm
# ===================
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# ===================
# Python (uv)
# ===================
export PATH="$HOME/.local/bin:$PATH"

# ===================
# Editor
# ===================
export EDITOR="code"
export VISUAL="code"

# ===================
# Language
# ===================
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# ===================
# Aliases
# ===================

# Modern CLI replacements
alias ls="eza --icons"
alias ll="eza -la --icons"
alias la="eza -a --icons"
alias lt="eza --tree --icons"
alias cat="bat"
alias grep="rg"
alias find="fd"

# Git
alias gs="git status"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"
alias glog="git log --oneline --graph --decorate"

# Docker
alias dps="docker ps"
alias dco="docker compose"
alias dcup="docker compose up -d"
alias dcdown="docker compose down"

# Kubernetes
alias k="kubectl"
alias kgp="kubectl get pods"
alias kgs="kubectl get services"
alias kgd="kubectl get deployments"

# Development
alias dev="pnpm dev"
alias build="pnpm build"
alias test="pnpm test"

# ===================
# Functions
# ===================

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Quick git commit
gcm() {
    git add -A && git commit -m "$1"
}

# Find and kill process on port
killport() {
    lsof -ti:$1 | xargs kill -9
}

# ===================
# Local config (not tracked)
# ===================
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
