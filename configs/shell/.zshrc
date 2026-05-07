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

# PostgreSQL CLI tools (libpq) — keg-only formula
# 踩坑：libpq 是 keg-only 包，brew 不会自动 link，psql/pg_dump 命令不会进 PATH
# 必须显式追加，否则连接 PG 时会找不到 psql 命令
if [[ "$(uname -m)" == "arm64" ]]; then
    [[ -d /opt/homebrew/opt/libpq/bin ]] && export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
else
    [[ -d /usr/local/opt/libpq/bin ]] && export PATH="/usr/local/opt/libpq/bin:$PATH"
fi

# Optional: LM Studio CLI (取消注释以启用)
# [[ -d "$HOME/.lmstudio/bin" ]] && export PATH="$PATH:$HOME/.lmstudio/bin"

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
# 踩坑 1：lazy loading 会让子进程（如 air 热重载）找不到 go 命令，必须直接加载
# 踩坑 2：homebrew 自带 go，会污染 PATH 优先级，必须把 goenv shims 强制前置
if command -v goenv >/dev/null 2>&1; then
    export GOENV_ROOT="$HOME/.goenv"
    export PATH="$GOENV_ROOT/bin:$PATH"
    eval "$(goenv init -)"
    # 强制 shims 前置覆盖 homebrew 的 go
    export PATH="$GOENV_ROOT/shims:$HOME/go/bin:$PATH"
fi

# Fast Node Manager (fnm) - Node.js version manager (direct loading for stability)
if command -v fnm >/dev/null 2>&1; then
    eval "$(fnm env --use-on-cd)"
fi

# =============================================================================
# Network Proxy Configuration
# =============================================================================
# 默认端口 7890（Clash/ClashX/Mihomo），可通过 PROXY_PORT 环境变量覆盖
export PROXY_PORT="${PROXY_PORT:-7890}"

# 通用代理：根据 PROXY_PORT 启用 HTTP/HTTPS/SOCKS5
function proxy() {
    export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
    export http_proxy="http://127.0.0.1:${PROXY_PORT}"
    export https_proxy=$http_proxy
    export all_proxy="socks5://127.0.0.1:${PROXY_PORT}"
    if command -v jq >/dev/null 2>&1; then
        curl -s -XGET "http://ip-api.com/json" | jq
    else
        curl -s -XGET "http://ip-api.com/json"
    fi
    echo -e "\n\033[32m✓ Proxy enabled (port ${PROXY_PORT})\033[0m"
}

# Clash 客户端专用别名（语义化）— 与 proxy() 等价，仅命名差异
function clash()     { proxy }
function clash_off() { proxy_off }

# Disable proxy
function proxy_off(){
    unset http_proxy
    unset https_proxy
    unset all_proxy
    echo -e "\033[33m✗ Proxy disabled\033[0m"
}

# Set proxy for Git (one-time)
function git_proxy() {
    git config --global http.proxy "http://127.0.0.1:${PROXY_PORT}"
    git config --global https.proxy "http://127.0.0.1:${PROXY_PORT}"
    echo "Git proxy configured (port ${PROXY_PORT})"
}

function git_proxy_off() {
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    echo "Git proxy removed"
}

# Uncomment to auto-enable proxy on terminal start (中国网络环境推荐):
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

# KUBECONFIG 多集群合并 — 自动扫描 ~/.kube/configs/*.yaml
# 踩坑：默认 kubectl 只读 ~/.kube/config，多集群场景需手动 export，且每加一个就要改一次
# 解法：动态扫描目录，新增集群只需把 yaml 丢到 ~/.kube/configs/ 即可
if [[ -d "$HOME/.kube" ]]; then
    _kubeconfigs="$HOME/.kube/config"
    if [[ -d "$HOME/.kube/configs" ]]; then
        for f in "$HOME"/.kube/configs/*.yaml(N) "$HOME"/.kube/configs/*.yml(N); do
            [[ -f "$f" ]] && _kubeconfigs="${_kubeconfigs}:${f}"
        done
    fi
    export KUBECONFIG="$_kubeconfigs"
    unset _kubeconfigs
fi

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

# Java version shortcuts — auto-detect latest installed amzn version
# 用法：java_switch 11 / java_switch 17 / java_switch 21
# 踩坑：硬编码版本号（如 "11.0.28-amzn"）每次升级都要改，改用动态匹配
function java_switch() {
    local major="${1:?Usage: java_switch <11|17|21>}"
    local vendor="${2:-amzn}"
    local version
    version=$(sdk list java 2>/dev/null | grep "${vendor}" | grep -E " ${major}\." | grep 'installed' | tail -1 | awk '{print $NF}')
    if [[ -z "$version" ]]; then
        echo "✗ No installed Java ${major} (${vendor}) found. Run: sdk install java <version>" >&2
        return 1
    fi
    sdk use java "$version"
}

# Convenience aliases for common versions
function java11() { java_switch 11 }
function java17() { java_switch 17 }
function java21() { java_switch 21 }

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
