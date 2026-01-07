# macOS Starter

> **From Zero to Hero** - 专为工程师打造的 macOS 开发环境配置指南
>
> YC & Silicon Valley & Elon Musk Standard

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-macOS-blue.svg)](https://www.apple.com/macos)
[![Architecture](https://img.shields.io/badge/Architecture-Apple%20Silicon-green.svg)](https://www.apple.com/mac)

## Philosophy

```
Ship Fast. Break Things. Fix Faster.
```

- **Minimal Friction** - 一键配置，零阻力启动
- **Battle-Tested** - 生产环境验证的工具链
- **Opinionated** - 有主见的配置，不浪费时间选择
- **Reproducible** - 可复现的开发环境

## Quick Start

```bash
# Clone this repo
git clone https://github.com/yourusername/macOS-Starter.git
cd macOS-Starter

# Run the bootstrap script
./scripts/bootstrap.sh
```

## What's Inside

### Core Stack

| Category | Tool | Why |
|----------|------|-----|
| **Package Manager** | [Homebrew](https://brew.sh) | macOS 的标准包管理器 |
| **Shell** | Zsh + Oh-My-Zsh + Starship | 现代化 Shell 体验 |
| **Terminal** | [Warp](https://warp.dev) | AI 驱动的现代终端 |
| **Launcher** | [Raycast](https://raycast.com) | Spotlight 替代 + 窗口管理 |
| **Version Control** | Git + gh CLI | GitHub 原生集成 |

### Development

| Category | Tool | Why |
|----------|------|-----|
| **Node.js** | fnm + pnpm | 快速版本管理 + 高效包管理 |
| **Python** | uv | Rust 构建，管理版本和依赖 |
| **Go** | goenv | 多版本管理 |
| **Container** | OrbStack | 轻量级 Docker/K8s (替代 Docker Desktop) |
| **Kubernetes** | kubectl + helm + k9s + kubeswitch | 云原生开发全套工具 |

### Editor & IDE

| Tool | Description |
|------|-------------|
| Cursor | AI-first 编辑器 (主力) |
| VS Code | 备用编辑器 |
| JetBrains Toolbox | JetBrains IDE 管理 |

### Vibe Coding (AI 辅助编程)

| Tool | Description |
|------|-------------|
| Claude Code | Anthropic 官方 CLI，终端中的 AI 编程助手 |
| Cursor | AI-first 代码编辑器 |
| OpenCode | 开源终端 AI 编程工具 |

### Essential Apps

| Category | Apps |
|----------|------|
| **必装** | Raycast, 1Password, Chrome, KeepingYouAwake, Keka |
| **开发** | Cursor, Warp, OrbStack, Apifox, Proxyman, Sourcetree |
| **工作** | 飞书, 钉钉, 企业微信, 腾讯会议, Notion |
| **AI** | Claude Code, LM Studio, Cherry Studio |
| **系统** | iStat Menus, MonitorControl, Gas Mask |

## Documentation

| Chapter | Description |
|---------|-------------|
| [01. System Setup](docs/01-system-setup.md) | 系统初始化配置 |
| [02. Homebrew](docs/02-homebrew.md) | 包管理器安装 |
| [03. Shell](docs/03-shell.md) | Zsh + Oh-My-Zsh 配置 |
| [04. Fonts](docs/04-fonts.md) | 编程字体安装 |
| [05. Dev Environment](docs/05-dev-environment.md) | Git, Node.js, Python, Go, Container |
| [06. Editor](docs/06-editor.md) | VS Code / Cursor 配置 |
| [07. Vibe Coding](docs/07-vibe-coding.md) | AI 辅助编程 (Claude Code, Cursor, OpenCode) |
| [08. Apps](docs/08-apps.md) | 推荐应用 |
| [09. macOS](docs/09-macos.md) | 系统优化 |

## Scripts

```bash
scripts/
├── bootstrap.sh          # 一键安装入口
├── Brewfile              # 核心包定义 (CLI, Apps, Fonts)
└── macos-defaults.sh     # macOS 系统配置 (可选)
```

**Usage:**

```bash
# 标准安装 (推荐)
./scripts/bootstrap.sh

# 包含 macOS 系统配置
./scripts/bootstrap.sh --with-macos-defaults
```

安装完成后，按照 `docs/` 目录中的文档完成 Node.js、Python、Git 等配置。

## Config Files

```bash
configs/
├── shell/
│   ├── .zshrc
│   └── .zprofile
├── git/
│   ├── .gitconfig
│   └── .gitignore_global
├── editors/
│   ├── vscode-settings.json
│   └── biome.json
└── terminal/
    └── starship.toml
```

## Current Environment Snapshot

基于 Larry's MacBook Pro (Apple Silicon) 的配置快照：

| Component | Version |
|-----------|---------|
| macOS | Darwin 25.1.0 |
| Node.js | v22.21.1 |
| npm | 10.9.4 |
| pnpm | 10.27.0 |
| Python | 3.14.0 (via uv) |
| Go | 1.23.9 |
| OrbStack | latest |
| kubectl | v1.32.7 |
| Helm | v4.0.1 |
| Git | 2.52.0 |

## Contributing

PRs welcome. Keep it simple. Ship fast.

## License

MIT License - Use it, modify it, ship it.

---

**Built with focus by engineers, for engineers.**
