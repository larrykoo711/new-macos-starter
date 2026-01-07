# 03. Shell

> Zsh + Oh-My-Zsh + Starship - 现代化 Shell 体验

## Zsh Setup

macOS 默认 Shell 已经是 Zsh。验证：

```bash
echo $SHELL
# /bin/zsh
```

## Oh-My-Zsh

### Installation

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### Plugins

编辑 `~/.zshrc`：

```bash
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
    z                    # 目录跳转
    zsh-autosuggestions  # 命令建议
    zsh-syntax-highlighting  # 语法高亮
)
```

安装第三方插件：

```bash
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### Theme

推荐使用 Starship（见下文）或内置主题：

```bash
# ~/.zshrc
ZSH_THEME="agnoster"  # 或 "robbyrussell", "powerlevel10k"
```

## Starship Prompt

### Installation

```bash
brew install starship

# 添加到 ~/.zshrc
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
```

### Configuration

创建 `~/.config/starship.toml`：

```toml
# Starship Configuration

# 提示符格式
format = """
$username\
$hostname\
$directory\
$git_branch\
$git_status\
$nodejs\
$python\
$golang\
$docker_context\
$cmd_duration\
$line_break\
$character"""

# 命令执行时间
[cmd_duration]
min_time = 500
format = "[$duration]($style) "

# 目录
[directory]
truncation_length = 3
truncate_to_repo = true

# Git 分支
[git_branch]
symbol = " "
format = "[$symbol$branch]($style) "

# Git 状态
[git_status]
format = '([\[$all_status$ahead_behind\]]($style) )'

# Node.js
[nodejs]
symbol = " "
format = "[$symbol($version )]($style)"

# Python
[python]
symbol = " "
format = '[${symbol}${pyenv_prefix}(${version} )(\($virtualenv\) )]($style)'

# Go
[golang]
symbol = " "
format = "[$symbol($version )]($style)"

# Docker
[docker_context]
symbol = " "
format = "[$symbol$context]($style) "

# 字符
[character]
success_symbol = "[❯](bold green)"
error_symbol = "[❯](bold red)"
```

## Zsh Configuration

### ~/.zshrc

```bash
# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme (使用 Starship 时注释掉)
# ZSH_THEME="robbyrussell"

# Plugins
plugins=(
    git
    docker
    kubectl
    z
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Starship
eval "$(starship init zsh)"

# fnm (Node.js)
eval "$(fnm env --use-on-cd)"

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
eval "$(goenv init -)"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Aliases
alias ll="eza -la --icons"
alias la="eza -a --icons"
alias lt="eza --tree --icons"
alias cat="bat"
alias grep="rg"
alias find="fd"

# Git aliases
alias gs="git status"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"

# Docker aliases
alias dps="docker ps"
alias dco="docker-compose"

# Kubernetes aliases
alias k="kubectl"
alias kgp="kubectl get pods"
alias kgs="kubectl get services"
```

### ~/.zprofile

```bash
# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# 编辑器
export EDITOR="code"
export VISUAL="code"

# 语言设置
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
```

## Modern CLI Tools

用现代工具替代传统命令：

| 传统命令 | 现代替代 | 安装 |
|---------|---------|------|
| `ls` | `eza` | `brew install eza` |
| `cat` | `bat` | `brew install bat` |
| `find` | `fd` | `brew install fd` |
| `grep` | `ripgrep` | `brew install ripgrep` |
| `cd` | `z` | oh-my-zsh plugin |
| `top` | `bottom` | `brew install bottom` |

## Tips

### 快速目录跳转

```bash
# 使用 z 插件
z project    # 跳转到包含 "project" 的目录
z -l         # 列出所有记录的目录
```

### 命令历史搜索

```bash
# Ctrl + R 搜索历史
# 或使用 fzf
brew install fzf
$(brew --prefix)/opt/fzf/install
```

### 自定义函数

```bash
# 创建目录并进入
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# 快速 Git commit
gcm() {
    git add -A && git commit -m "$1"
}
```

## Next Steps

继续 [04. Fonts](04-fonts.md) 安装编程字体。
