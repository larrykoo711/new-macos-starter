# =============================================================================
# ZSH Configuration (Performance Optimized)
# From: macOS Starter - https://github.com/larrykoo711/new-macos-starter
# =============================================================================

# Oh-My-Zsh installation path
export ZSH="$HOME/.oh-my-zsh"

# Theme configuration - disabled for Starship
# ZSH_THEME="bullet-train"
ZSH_THEME=""  # Use Starship instead

# Oh-My-Zsh plugins (optimized)
plugins=(
    git
    kubectl
    wd
    jsontools
    autojump
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Load Oh-My-Zsh
source $ZSH/oh-my-zsh.sh

# =============================================================================
# Package Managers & Environment Setup
# =============================================================================

# Note: Homebrew is initialized in .zprofile for login shells
# This ensures brew is available in non-login shells too
[[ -z "$HOMEBREW_PREFIX" ]] && {
    if [[ "$(uname -m)" == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
}

# Autojump (if installed)
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# =============================================================================
# Development Environment Variables
# =============================================================================

# Development settings
export JVM_ARGS="-Xms1024m -Xmx2048m"
export PYTORCH_ENABLE_MPS_FALLBACK=1
export GIT_LFS_SKIP_SMUDGE=1

# Editor & Language (also in .zprofile, kept here for non-login shells)
export EDITOR="${EDITOR:-code}"
export VISUAL="${VISUAL:-code}"
export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-en_US.UTF-8}"

# =============================================================================
# PATH Configuration
# =============================================================================

# Add development tools to PATH (order matters - higher priority first)
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Add JAVA_HOME to PATH only if it's defined (managed by SDKMAN)
[[ -n "$JAVA_HOME" ]] && export PATH="$JAVA_HOME/bin:$PATH"

# =============================================================================
# Language Version Managers - LAZY LOADING
# =============================================================================

# Python environment management using uv
if command -v uv >/dev/null 2>&1; then
    eval "$(uv generate-shell-completion zsh)"
fi

# goenv - Go version manager (direct loading for subprocess compatibility)
# Note: Lazy loading breaks subprocesses (like air) that need 'go' in PATH
if command -v goenv >/dev/null 2>&1; then
    export GOENV_ROOT="$HOME/.goenv"
    export PATH="$GOENV_ROOT/bin:$PATH"
    eval "$(goenv init -)"
    export PATH="$GOPATH/bin:$PATH"
    export PATH="$HOME/go/bin:$PATH"
fi

# Fast Node Manager (fnm) - Node.js version manager (direct loading for stability)
if command -v fnm >/dev/null 2>&1; then
    eval "$(fnm env --use-on-cd)"
fi

# =============================================================================
# Network Proxy Configuration
# =============================================================================

# Enable network proxy
function proxy() {
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
    export http_proxy="http://127.0.0.1:7890"
    export https_proxy=$http_proxy
    export all_proxy=socks5://127.0.0.1:7890
    curl -s -XGET "http://ip-api.com/json" | jq
    echo -e "\\n"
    echo -e "\\033[32mProxy enabled\\033[0m"
}

# Disable proxy
function proxy_off(){
    unset http_proxy
    unset https_proxy
    unset all_proxy
    echo -e "Proxy disabled"
}

# Set proxy for Git (one-time)
function git_proxy() {
    git config --global http.proxy "http://127.0.0.1:7890"
    git config --global https.proxy "http://127.0.0.1:7890"
    echo "Git proxy configured"
}

function git_proxy_off() {
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    echo "Git proxy removed"
}

# Uncomment to auto-enable proxy on terminal start:
# proxy

# =============================================================================
# Aliases - System Management
# =============================================================================

# Claude Code with permissions bypass (use with caution)
alias jarvis="claude --dangerously-skip-permissions"

# Configuration file shortcuts
alias zshf="source ~/.zshrc"
alias zshconf="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias sshconf="code ~/.ssh/config"

# =============================================================================
# Aliases - Modern CLI Replacements
# =============================================================================

# eza (modern ls)
alias ls="eza --icons"
alias ll="eza -la --icons"
alias la="eza -a --icons"
alias lt="eza --tree --icons"
alias llt="eza -la --tree --icons"

# bat (modern cat)
alias cat="bat"

# Keep native grep/find, use rg/fd as separate commands
# alias grep="rg"
# alias find="fd"

# =============================================================================
# Aliases - Git
# =============================================================================

alias gs="git status"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"
alias glog="git log --oneline --graph --decorate"

# =============================================================================
# Aliases - Docker & Kubernetes
# =============================================================================

alias dps="docker ps"
alias dco="docker compose"
alias dcup="docker compose up -d"
alias dcdown="docker compose down"

alias k="kubectl"
alias kgp="kubectl get pods"
alias kgs="kubectl get services"
alias kgd="kubectl get deployments"

# =============================================================================
# Aliases - Development Tools
# =============================================================================

# Python (use python3 as default)
alias python="python3"
alias pyhttp="python3 -m http.server"

# pnpm shortcuts
alias dev="pnpm dev"
alias build="pnpm build"
alias test="pnpm test"

# File operations
alias psg='ps auxf | grep'
alias grep="grep --color=auto"

# =============================================================================
# File Type Associations
# =============================================================================

alias -s zip="unzip"
alias -s gz="tar -zxvf"
alias -s tgz="tar -xzvf"
alias -s bz2="tar -xjvf"

# =============================================================================
# Utility Functions
# =============================================================================

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

# =============================================================================
# Rust Cargo
# =============================================================================

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# =============================================================================
# Cloud CLI Configuration - LAZY LOADING
# =============================================================================

# AWS CLI lazy loading
function aws() {
    if command -v /opt/homebrew/bin/aws >/dev/null 2>&1; then
        complete -C '/opt/homebrew/bin/aws_completer' aws
    fi
    unfunction "$0"
    command aws "$@"
}

# Google Cloud SDK lazy loading
function gcloud() {
    if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then
        source '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'
    fi
    if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]; then
        source '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'
    fi
    unfunction "$0"
    gcloud "$@"
}

function gsutil() {
    if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then
        source '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'
    fi
    unfunction "$0"
    gsutil "$@"
}

function bq() {
    if [ -f '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc' ]; then
        source '/opt/homebrew/share/google-cloud-sdk/path.zsh.inc'
    fi
    unfunction "$0"
    bq "$@"
}

# =============================================================================
# SDKMAN - Java Ecosystem Management (MUST BE AT THE END)
# =============================================================================

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Java version shortcuts (auto-detect latest installed versions)
function java11() {
    sdk use java $(sdk list java | grep 'amzn' | grep '11' | grep 'installed' | tail -1 | awk '{print $NF}')
}

function java21() {
    sdk use java $(sdk list java | grep 'amzn' | grep '21' | grep 'installed' | tail -1 | awk '{print $NF}')
}

# =============================================================================
# Performance Optimization Functions
# =============================================================================

# Function to manually initialize all lazy-loaded components
function init_all_dev_tools() {
    echo "Initializing all development tools..."
    (( $+functions[goenv] )) && goenv --version >/dev/null
    (( $+functions[aws] )) && aws --version >/dev/null
    (( $+functions[gcloud] )) && gcloud --version >/dev/null
    echo "All development tools initialized!"
}

# Function to check zsh startup time
function zsh_bench() {
    for i in {1..5}; do
        echo "Test $i:"
        time (zsh -i -c exit)
    done
}

# =============================================================================
# Bun (if installed)
# =============================================================================

[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# =============================================================================
# pnpm
# =============================================================================

export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# =============================================================================
# Final Prompt Configuration
# =============================================================================

PROMPT="${PROMPT}"$'\n'

# =============================================================================
# Starship Prompt (MUST BE AT THE END)
# =============================================================================

eval "$(starship init zsh)"

# =============================================================================
# Local config (not tracked)
# =============================================================================
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
