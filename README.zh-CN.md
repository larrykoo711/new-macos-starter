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

### 方式一：AI 驱动的交互式安装（推荐）

使用 [Claude Code](https://claude.ai/claude-code) 或 [Cursor](https://cursor.sh) 获得个性化的对话式安装体验：

```bash
# 克隆仓库
git clone https://github.com/larrykoo711/new-macos-starter.git
cd new-macos-starter

# 在 Claude Code 或 Cursor 终端中启动安装向导
/new-macos-setup
```

AI 向导会：
1. **检测** 系统已安装的软件
2. **询问** 你的偏好（角色、语言、应用）
3. **生成** 定制化的安装计划
4. **执行** 分步安装并跟踪进度

```bash
# 使用默认配置快速安装
/new-macos-setup --quick

# 使用预设（fullstack, frontend, backend, data, devops）
/new-macos-setup --preset fullstack

# 预览安装计划（不实际安装）
/new-macos-setup --dry-run
```

### 方式二：传统脚本安装

```bash
# 克隆仓库
git clone https://github.com/larrykoo711/new-macos-starter.git
cd new-macos-starter

# 运行引导脚本（安装基础依赖）
./scripts/bootstrap.sh
```

bootstrap.sh 会安装 Xcode CLI Tools、Rosetta 2（Apple Silicon）和 Homebrew。然后引导你使用 AI 向导 `/new-macos-setup` 完成完整配置。

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
| [00. 故障排除](docs/00-troubleshooting.md) | 常见问题解决方案 |
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
├── .claude/
│   ├── commands/
│   │   └── new-macos-setup.md     # /new-macos-setup 命令入口
│   └── skills/
│       └── macos-setup/          # AI 安装向导技能
│           ├── SKILL.md          # 技能定义 + 问答流程
│           ├── presets.md        # 角色预设（5 种配置）
│           └── packages.md       # 完整包注册表
├── scripts/
│   ├── bootstrap.sh              # 基础依赖安装（Homebrew）
│   ├── verify.sh                 # 安装验证脚本
│   └── Brewfile                  # Homebrew 包定义
├── configs/
│   ├── shell/                    # .zshrc, .zprofile
│   ├── git/                      # .gitconfig, .gitignore_global
│   ├── editors/                  # VS Code 设置, Biome 配置
│   └── terminal/                 # Starship 提示符配置
└── docs/                         # 分步指南（01-09）
```

## 自定义

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

### 验证安装

安装完成后，验证所有工具是否正确安装：

```bash
./scripts/verify.sh
```

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
