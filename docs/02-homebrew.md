# 02. Homebrew

> macOS 的包管理器 - 一切的基础

**图例**: 🆓 免费开源 | 💰 付费 | 🔄 Freemium | 📦 Homebrew 可安装

---

## Installation

> 🆓 **开源免费** | [官网](https://brew.sh) | [GitHub](https://github.com/Homebrew/brew)

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

---

## Essential Formulae

### Development Tools

| 工具 | 说明 | 定价 | 安装方式 |
|------|------|------|----------|
| **git** | 版本控制 | 🆓 开源免费 | 📦 `brew install git` |
| **gh** | GitHub CLI | 🆓 开源免费 | 📦 `brew install gh` |
| **delta** | 更好的 diff | 🆓 开源免费 | 📦 `brew install delta` |
| **starship** | 现代化提示符 | 🆓 开源免费 | 📦 `brew install starship` |
| **eza** | 更好的 ls | 🆓 开源免费 | 📦 `brew install eza` |
| **bat** | 更好的 cat | 🆓 开源免费 | 📦 `brew install bat` |
| **fd** | 更好的 find | 🆓 开源免费 | 📦 `brew install fd` |
| **ripgrep** | 更好的 grep | 🆓 开源免费 | 📦 `brew install ripgrep` |
| **bottom** | 系统监控 TUI | 🆓 开源免费 | 📦 `brew install bottom` |
| **jq** | JSON 处理 | 🆓 开源免费 | 📦 `brew install jq` |
| **yq** | YAML 处理 | 🆓 开源免费 | 📦 `brew install yq` |
| **autojump** | 目录快速跳转 | 🆓 开源免费 | 📦 `brew install autojump` |

```bash
# 版本控制
brew install git gh delta

# Shell 增强
brew install starship autojump

# 文件操作
brew install tree fd ripgrep bat eza

# 系统监控
brew install bottom

# 网络工具
brew install curl wget jq yq
```

### Programming Languages

| 工具 | 说明 | 定价 | 安装方式 |
|------|------|------|----------|
| **fnm** | Node.js 版本管理 | 🆓 开源免费 | 📦 `brew install fnm` |
| **uv** | Python 环境管理 | 🆓 开源免费 | 📦 `brew install uv` |
| **goenv** | Go 版本管理 | 🆓 开源免费 | 📦 `brew install goenv` |
| **go** | Go 语言 | 🆓 开源免费 | 📦 `brew install go` |

```bash
# Node.js 版本管理
brew install fnm

# Python (uv 管理版本和依赖)
brew install uv

# Go
brew install goenv go
```

### Container & Kubernetes

| 工具 | 说明 | 定价 | 安装方式 |
|------|------|------|----------|
| **kubectl** | K8s CLI | 🆓 开源免费 | 📦 `brew install kubectl` |
| **helm** | K8s 包管理 | 🆓 开源免费 | 📦 `brew install helm` |
| **k9s** | K8s TUI | 🆓 开源免费 | 📦 `brew install k9s` |
| **stern** | 多 Pod 日志 | 🆓 开源免费 | 📦 `brew install stern` |
| **kubeswitch** | Context 切换 | 🆓 开源免费 | 📦 需先 tap |

```bash
# Kubernetes CLI
brew install kubectl helm k9s stern

# kubeswitch (context 切换，比 kubectx 更强大)
brew tap danielfoehrkn/switch
brew install danielfoehrkn/switch/switch
```

### Cloud & Platform CLI

| 工具 | 说明 | 定价 | 安装方式 |
|------|------|------|----------|
| **awscli** | AWS CLI | 🆓 免费 (AWS 收费) | 📦 `brew install awscli` |
| **google-cloud-sdk** | GCP CLI | 🆓 免费 (GCP 收费) | 📦 `brew install google-cloud-sdk` |
| **azure-cli** | Azure CLI | 🆓 免费 (Azure 收费) | 📦 `brew install azure-cli` |
| **rclone** | 通用云存储 | 🆓 开源免费 | 📦 `brew install rclone` |

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

---

## Cask Applications

### 必装应用

| App | 说明 | 定价 | 安装方式 |
|-----|------|------|----------|
| **Raycast** | Spotlight 替代 + 窗口管理 | 🔄 基础免费/Pro $8/月 | 📦 `brew install --cask raycast` |
| **1Password** | 密码管理 | 💰 $2.99/月起 | 📦 `brew install --cask 1password` |
| **Google Chrome** | 浏览器 | 🆓 免费 | 📦 `brew install --cask google-chrome` |
| **KeepingYouAwake** | 防休眠 | 🆓 开源免费 | 📦 `brew install --cask keepingyouawake` |
| **Keka** | 解压缩 | 🆓 开源/AppStore $5.99 | 📦 `brew install --cask keka` |
| **AppCleaner** | 应用卸载 | 🆓 免费 | 📦 `brew install --cask appcleaner` |

```bash
brew install --cask raycast 1password google-chrome
brew install --cask keepingyouawake keka appcleaner
```

### 开发工具

| App | 说明 | 定价 | 安装方式 |
|-----|------|------|----------|
| **VS Code** | 代码编辑器（推荐主力） | 🆓 免费 | 📦 `brew install --cask visual-studio-code` |
| **Ghostty** | 现代 GPU 加速终端（推荐） | 🆓 开源免费 | 📦 `brew install --cask ghostty` |
| **tmux** | 终端复用器（与 Ghostty 配合） | 🆓 开源免费 | 📦 `brew install tmux` |
| **Warp** | AI 终端（替代选项） | 🔄 基础免费/Team 付费 | 📦 `brew install --cask warp` |
| **OrbStack** | Docker/K8s | 🔄 个人免费/Pro $8/月 | 📦 `brew install --cask orbstack` |
| **Proxyman** | HTTP 调试 | 🔄 基础免费/$59 永久 | 📦 `brew install --cask proxyman` |
| **Sourcetree** | Git GUI | 🆓 免费 | 📦 `brew install --cask sourcetree` |

```bash
brew install --cask visual-studio-code ghostty
brew install tmux
brew install --cask orbstack proxyman sourcetree
```

### 设计 & 媒体

| App | 说明 | 定价 | 安装方式 |
|-----|------|------|----------|
| **IINA** | 视频播放器 | 🆓 开源免费 | 📦 `brew install --cask iina` |
| **ImageOptim** | 图片压缩 | 🆓 开源免费 | 📦 `brew install --cask imageoptim` |

```bash
brew install --cask iina imageoptim
```

### 工作 & 协作

| App | 说明 | 定价 | 安装方式 |
|-----|------|------|----------|
| **飞书 (Lark)** | 字节办公套件 | 🔄 基础免费/企业付费 | 📦 `brew install --cask lark` |
| **微信** | 个人通讯 | 🆓 免费 | 📦 `brew install --cask wechat` |
| **腾讯会议** | 视频会议 | 🔄 基础免费/企业付费 | 📦 `brew install --cask tencent-meeting` |

```bash
brew install --cask lark wechat tencent-meeting
```

> 国际通讯（Slack/Discord/WhatsApp/Notion 等）易于自行下载，故不再纳入默认列表。

### AI 工具

| App | 说明 | 定价 | 安装方式 |
|-----|------|------|----------|
| **Claude Code** | Anthropic AI CLI | 🔄 API 付费 | 📦 `brew install --cask claude-code` |
| **Cherry Studio** | 多模型 AI 桌面客户端 | 🆓 免费 | 📦 `brew install --cask cherry-studio` |

```bash
brew install --cask claude-code cherry-studio
```

### 系统增强

| App | 说明 | 定价 | 安装方式 |
|-----|------|------|----------|
| **iStat Menus** | 系统监控 | 💰 $9.99/SetApp | 📦 `brew install --cask istat-menus` |
| **coconutBattery** | 电池监控 | 🔄 基础免费/Plus €9.95 | 📦 `brew install --cask coconutbattery` |
| **MonitorControl** | 外接显示器亮度 | 🆓 开源免费 | 📦 `brew install --cask monitorcontrol` |
| **Gas Mask** | Hosts 管理 | 🆓 开源免费 | 📦 `brew install --cask gas-mask` |
| **balenaEtcher** | 启动盘制作 | 🆓 开源免费 | 📦 `brew install --cask balenaetcher` |
| **OpenInTerminal-Lite** | Finder 打开终端 | 🆓 开源免费 | 📦 `brew install --cask openinterminal-lite` |
| **QLMarkdown** | Markdown 预览 | 🆓 开源免费 | 📦 `brew install --cask qlmarkdown` |
| **Syntax Highlight** | 代码预览 | 🆓 开源免费 | 📦 `brew install --cask syntax-highlight` |

```bash
brew install --cask istat-menus coconutbattery monitorcontrol
brew install --cask gas-mask balenaetcher openinterminal-lite
brew install --cask qlmarkdown syntax-highlight
```

### 其他

```bash
brew install --cask neteasemusic     # 网易云音乐 (🔄 基础免费/会员付费)
```

---

## Taps

```bash
# 添加额外的仓库
brew tap homebrew/services
brew tap danielfoehrkn/switch        # kubeswitch
```

> **注意**: `homebrew/cask-fonts` 已弃用，字体 cask 现已合并到主仓库。

---

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
