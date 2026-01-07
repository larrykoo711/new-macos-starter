# 02. Homebrew

> macOS 的包管理器 - 一切的基础

## Installation

```bash
# 安装 Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Post-Installation (Apple Silicon)

```bash
# 添加到 PATH
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# 验证安装
brew --version
```

## Configuration

### 镜像源配置 (中国用户)

```bash
# 设置 Homebrew 镜像
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"

# 添加到 .zshrc
cat >> ~/.zshrc << 'EOF'
# Homebrew 镜像 (USTC)
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
EOF
```

## Essential Formulae

### Development Tools

```bash
# 版本控制
brew install git
brew install gh              # GitHub CLI
brew install delta           # Better git diff

# Shell 增强
brew install zsh
brew install starship        # Modern prompt

# 文件操作
brew install tree
brew install fd              # 更好的 find
brew install ripgrep         # 更好的 grep
brew install bat             # 更好的 cat
brew install eza             # 更好的 ls

# 系统监控
brew install bottom          # 系统监控 TUI

# 网络工具
brew install curl
brew install wget
brew install jq
brew install yq
```

### Programming Languages

```bash
# Node.js 版本管理
brew install fnm

# Python (uv 管理版本和依赖)
brew install uv

# Go
brew install goenv
brew install go
```

### Container & Kubernetes

```bash
# Kubernetes CLI
brew install kubectl
brew install helm
brew install k9s              # K8s TUI
brew install stern            # 多 Pod 日志

# kubeswitch (context 切换，比 kubectx 更强大)
brew tap danielfoehrkn/switch
brew install danielfoehrkn/switch/switch
```

### Cloud & Platform CLI

```bash
# Cloud Providers
brew install awscli                     # AWS
brew install google-cloud-sdk           # GCP (按需)
brew install azure-cli                  # Azure (按需)

# Deployment Platforms (推荐用 pnpm 全局安装)
pnpm add -g vercel                      # Vercel
pnpm add -g wrangler                    # Cloudflare Workers

# Storage
brew install rclone                     # 通用云存储 CLI
```

## Cask Applications

### 必装应用

```bash
brew install --cask raycast          # Spotlight + 窗口管理
brew install --cask 1password        # 密码管理
brew install --cask google-chrome    # 浏览器
brew install --cask keepingyouawake  # 防休眠
brew install --cask keka             # 解压缩
brew install --cask appcleaner       # 应用卸载
```

### 开发工具

```bash
brew install --cask cursor           # AI 编辑器 (主力)
brew install --cask visual-studio-code
brew install --cask warp             # AI 终端
brew install --cask orbstack         # Docker/K8s
brew install --cask apifox           # API 开发
brew install --cask proxyman         # HTTP 调试
brew install --cask sourcetree       # Git GUI
brew install --cask jetbrains-toolbox
```

### 设计 & 媒体

```bash
brew install --cask iina             # 视频播放
brew install --cask imageoptim       # 图片压缩
brew install --cask eagle            # 素材管理
```

### 工作 & 协作

```bash
brew install --cask lark             # 飞书
brew install --cask dingtalk         # 钉钉
brew install --cask wecom            # 企业微信
brew install --cask wechat           # 微信
brew install --cask discord
brew install --cask whatsapp
brew install --cask tencent-meeting  # 腾讯会议
brew install --cask notion
```

### AI 工具

```bash
brew install --cask lm-studio        # 本地大模型
```

### 系统增强

```bash
brew install --cask istat-menus      # 系统监控
brew install --cask coconutbattery   # 电池监控
brew install --cask monitorcontrol   # 外接显示器亮度
brew install --cask gas-mask         # Hosts 管理
brew install --cask balenaetcher     # 启动盘制作
brew install --cask openinterminal-lite
brew install --cask qlmarkdown
brew install --cask syntax-highlight
```

### 其他

```bash
brew install --cask neteasemusic     # 网易云音乐
```

## Taps

```bash
# 添加额外的仓库
brew tap homebrew/cask-fonts
brew tap homebrew/services
brew tap danielfoehrkn/switch        # kubeswitch
```

## Brewfile

创建 `Brewfile` 用于批量安装 (详见 `scripts/Brewfile`)：

```bash
# 安装所有内容
brew bundle install --file=scripts/Brewfile
```

## Maintenance

```bash
# 更新 Homebrew
brew update

# 升级所有包
brew upgrade

# 清理旧版本
brew cleanup

# 检查问题
brew doctor

# 查看已安装的包
brew list --formula
brew list --cask
```

## Export/Import

```bash
# 导出当前安装
brew bundle dump --file=~/Brewfile

# 从 Brewfile 安装
brew bundle install --file=~/Brewfile
```

## Next Steps

继续 [03. Shell](03-shell.md) 配置终端环境。
