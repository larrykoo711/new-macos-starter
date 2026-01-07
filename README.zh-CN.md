# macOS Starter

> **From Zero to Hero** — 专为工程师打造的 macOS 开发环境配置指南

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-macOS-blue.svg)](https://www.apple.com/macos)
[![Architecture](https://img.shields.io/badge/Architecture-Apple%20Silicon%20%7C%20Intel-green.svg)](https://www.apple.com/mac)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

**[English](README.md)**

## 理念

```
Ship Fast. Break Things. Fix Faster.
```

- **零阻力** — 一键配置，立即开始编码
- **经过实战检验** — 顶级工程师使用的生产级工具链
- **有主见** — 精选配置，不浪费时间做选择
- **可复现** — 在所有机器上保持一致的开发环境

## 快速开始

```bash
# 克隆仓库
git clone https://github.com/larrykoo711/new-macos-starter.git
cd new-macos-starter

# 运行安装脚本
./scripts/bootstrap.sh
```

就这么简单！脚本会自动安装 Homebrew、CLI 工具、应用程序、字体以及 Oh-My-Zsh 和插件。

### 可选参数

```bash
# 标准安装（推荐）
./scripts/bootstrap.sh

# 包含 macOS 系统偏好设置优化
./scripts/bootstrap.sh --with-macos-defaults
```

## 包含内容

### 核心工具栈

| 类别 | 工具 | 理由 |
|------|------|------|
| **包管理器** | [Homebrew](https://brew.sh) | macOS 的标准包管理器 |
| **Shell** | Zsh + Oh-My-Zsh + Starship | 现代化 Shell 体验，美观的命令提示符 |
| **终端** | [Warp](https://warp.dev) | AI 驱动的现代终端 |
| **启动器** | [Raycast](https://raycast.com) | Spotlight 替代品 + 窗口管理 |
| **版本控制** | Git + gh CLI | GitHub 原生集成 |

### 开发环境

| 类别 | 工具 | 理由 |
|------|------|------|
| **Node.js** | fnm + pnpm | 快速版本管理 + 高效包管理 |
| **Python** | uv | Rust 构建，同时管理版本和依赖 |
| **Go** | goenv | 多版本管理 |
| **容器** | OrbStack | 轻量级 Docker/K8s（替代 Docker Desktop） |
| **Kubernetes** | kubectl + helm + k9s + kubeswitch | 完整的云原生工具包 |

### 编辑器 & IDE

| 工具 | 说明 |
|------|------|
| [Cursor](https://cursor.sh) | AI-first 代码编辑器（主力） |
| [VS Code](https://code.visualstudio.com) | 备用编辑器 |
| [JetBrains Toolbox](https://www.jetbrains.com/toolbox-app/) | JetBrains IDE 管理器 |

### Vibe Coding（AI 辅助编程）

| 工具 | 说明 |
|------|------|
| [Claude Code](https://claude.ai/claude-code) | Anthropic 官方 CLI，终端中的 AI 编程助手 |
| [Cursor](https://cursor.sh) | AI-first 代码编辑器 |
| [OpenCode](https://github.com/opencode-ai/opencode) | 开源终端 AI 编程工具 |

### 必备应用

| 类别 | 应用 |
|------|------|
| **必装** | Raycast, 1Password, Chrome, KeepingYouAwake, Keka |
| **开发** | Cursor, Warp, OrbStack, Apifox, Proxyman, Sourcetree |
| **工作** | 飞书, 钉钉, 企业微信, 腾讯会议, Notion |
| **AI 工具** | Claude Code, LM Studio |
| **系统** | iStat Menus, MonitorControl, Gas Mask |

## 文档

| 章节 | 说明 |
|------|------|
| [01. 系统设置](docs/01-system-setup.md) | 系统初始化配置 |
| [02. Homebrew](docs/02-homebrew.md) | 包管理器安装 |
| [03. Shell](docs/03-shell.md) | Zsh + Oh-My-Zsh 配置 |
| [04. 字体](docs/04-fonts.md) | 编程字体安装 |
| [05. 开发环境](docs/05-dev-environment.md) | Git, Node.js, Python, Go, Container |
| [06. 编辑器](docs/06-editor.md) | VS Code / Cursor 配置 |
| [07. Vibe Coding](docs/07-vibe-coding.md) | AI 辅助编程工具 |
| [08. 应用](docs/08-apps.md) | 推荐应用 |
| [09. macOS](docs/09-macos.md) | 系统优化 |

## 项目结构

```
macOS-Starter/
├── scripts/
│   ├── bootstrap.sh          # 一键安装入口
│   ├── Brewfile              # Homebrew 包定义（CLI、应用、字体）
│   └── macos-defaults.sh     # macOS 系统偏好设置（可选）
├── configs/
│   ├── shell/                # .zshrc, .zprofile
│   ├── git/                  # .gitconfig, .gitignore_global
│   ├── editors/              # VS Code 设置, Biome 配置
│   └── terminal/             # Starship 提示符配置
└── docs/                     # 分步指南（01-09）
```

## 自定义

### 使用 Brewfile

编辑 `scripts/Brewfile` 来添加或删除包：

```ruby
# 添加 CLI 工具
brew "your-tool"

# 添加应用
cask "your-app"

# 添加字体
cask "font-your-font"
```

然后运行：

```bash
brew bundle install --file=scripts/Brewfile
```

### 安装后配置

运行 `bootstrap.sh` 后，完成以下手动配置：

```bash
# 1. 设置 Node.js
fnm install --lts
fnm default lts-latest

# 2. 设置 Python
uv python install 3.12

# 3. 配置 Git（填入你的信息）
git config --global user.name "你的名字"
git config --global user.email "your.email@example.com"
```

详细指南请参阅 [文档](docs/)。

## 测试环境

| 组件 | 版本 |
|------|------|
| macOS | Sequoia 15.x / Sonoma 14.x |
| 架构 | Apple Silicon (M1/M2/M3/M4) / Intel |
| Homebrew | 4.x |
| Node.js | 22.x LTS |
| Python | 3.12+ |
| Go | 1.23+ |

## 贡献

欢迎贡献！请在提交 PR 之前阅读我们的 [贡献指南](CONTRIBUTING.md) 和 [行为准则](CODE_OF_CONDUCT.md)。

- 发现 Bug？[提交 Issue](https://github.com/larrykoo711/new-macos-starter/issues/new?template=bug_report.md)
- 有新想法？[开始讨论](https://github.com/larrykoo711/new-macos-starter/issues/new?template=feature_request.md)
- 想要贡献？[提交 PR](https://github.com/larrykoo711/new-macos-starter/pulls)

## 许可证

[MIT 许可证](LICENSE) — 随意使用、修改、分发。

## 致谢

灵感来自 YC 创业公司、硅谷科技公司和开源社区的工程文化。

---

<p align="center">
  <strong>由工程师打造，为工程师服务。</strong>
</p>
