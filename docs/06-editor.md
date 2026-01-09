# 06. Editor

> 代码编辑器配置 - 生产力核心

**图例**: 🆓 免费开源 | 💰 付费 | 🔄 Freemium | 📦 Homebrew 可安装

---

## 编辑器总览

| 编辑器 | 说明 | 定价 | 安装方式 |
|--------|------|------|----------|
| **VS Code** | 微软代码编辑器 | 🆓 免费 | 📦 `brew install --cask visual-studio-code` |
| **Cursor** | AI-first 编辑器 | 🔄 Freemium/$20月 Pro | 📦 `brew install --cask cursor` |
| **Neovim** | 现代化 Vim | 🆓 开源免费 | 📦 `brew install neovim` |

---

## VS Code

> 🆓 **免费** | 📦 Homebrew | [官网](https://code.visualstudio.com)

### Installation

```bash
brew install --cask visual-studio-code
```

### 命令行集成

打开 VS Code → Command Palette (⇧⌘P) → `Shell Command: Install 'code' command in PATH`

```bash
# 使用
code .              # 打开当前目录
code file.js        # 打开文件
code -n .           # 新窗口打开
code -d file1 file2 # 比较文件
```

---

## Essential Extensions

### 核心扩展

| 扩展 | 说明 | 定价 |
|------|------|------|
| **Biome** | Linter + Formatter | 🆓 开源免费 |
| **GitLens** | Git 增强 | 🔄 Freemium |
| **Error Lens** | 内联错误显示 | 🆓 开源免费 |
| **Path Intellisense** | 路径补全 | 🆓 开源免费 |

```bash
# Biome (Linter + Formatter)
code --install-extension biomejs.biome

# GitLens
code --install-extension eamodio.gitlens

# Error Lens
code --install-extension usernamehw.errorlens

# Path Intellisense
code --install-extension christian-kohler.path-intellisense
```

### 语言支持

| 扩展 | 语言 | 定价 |
|------|------|------|
| **ESLint** | JavaScript/TypeScript | 🆓 开源免费 |
| **Tailwind CSS** | Tailwind CSS | 🆓 开源免费 |
| **Python** | Python | 🆓 免费 |
| **Ruff** | Python Linter | 🆓 开源免费 |
| **Go** | Go 语言 | 🆓 免费 |
| **Docker** | Docker | 🆓 免费 |
| **YAML** | YAML | 🆓 免费 |

```bash
# TypeScript/JavaScript
code --install-extension dbaeumer.vscode-eslint

# Tailwind CSS
code --install-extension bradlc.vscode-tailwindcss

# Python
code --install-extension ms-python.python
code --install-extension charliermarsh.ruff

# Go
code --install-extension golang.go

# Docker
code --install-extension ms-azuretools.vscode-docker

# YAML
code --install-extension redhat.vscode-yaml
```

### 主题与图标

| 扩展 | 说明 | 定价 |
|------|------|------|
| **One Dark Pro** | 流行暗色主题 | 🆓 开源免费 |
| **Material Icon** | 文件图标主题 | 🆓 开源免费 |
| **GitHub Theme** | GitHub 风格主题 | 🆓 开源免费 |

```bash
# One Dark Pro
code --install-extension zhuangtongfa.material-theme

# Material Icon Theme
code --install-extension pkief.material-icon-theme

# GitHub Theme
code --install-extension github.github-vscode-theme
```

### 生产力

| 扩展 | 说明 | 定价 |
|------|------|------|
| **Code Spell Checker** | 拼写检查 | 🆓 开源免费 |
| **Todo Tree** | TODO 管理 | 🆓 开源免费 |
| **Better Comments** | 注释增强 | 🆓 开源免费 |
| **Bookmarks** | 代码书签 | 🆓 开源免费 |

```bash
# Code Spell Checker
code --install-extension streetsidesoftware.code-spell-checker

# Todo Tree
code --install-extension gruntfuggly.todo-tree

# Better Comments
code --install-extension aaron-bond.better-comments

# Bookmarks
code --install-extension alefragnani.bookmarks
```

### AI 辅助

| 扩展 | 说明 | 定价 |
|------|------|------|
| **GitHub Copilot** | AI 代码补全 | 💰 $10/月 |
| **Codeium** | AI 代码补全 (免费替代) | 🆓 免费 |

```bash
# GitHub Copilot
code --install-extension github.copilot

# Codeium (免费替代)
code --install-extension codeium.codeium
```

---

## Settings

### settings.json

```json
{
  // 编辑器
  "editor.fontSize": 14,
  "editor.fontFamily": "JetBrains Mono, Menlo, Monaco, 'Courier New', monospace",
  "editor.fontLigatures": true,
  "editor.lineHeight": 1.6,
  "editor.tabSize": 2,
  "editor.insertSpaces": true,
  "editor.detectIndentation": false,
  "editor.renderWhitespace": "selection",
  "editor.wordWrap": "on",
  "editor.minimap.enabled": false,
  "editor.bracketPairColorization.enabled": true,
  "editor.guides.bracketPairs": true,
  "editor.cursorBlinking": "smooth",
  "editor.cursorSmoothCaretAnimation": "on",
  "editor.smoothScrolling": true,
  "editor.linkedEditing": true,
  "editor.formatOnSave": true,
  "editor.formatOnPaste": true,
  "editor.defaultFormatter": "biomejs.biome",
  "editor.codeActionsOnSave": {
    "source.organizeImports": "explicit",
    "source.fixAll": "explicit"
  },

  // 窗口
  "window.titleBarStyle": "custom",
  "window.zoomLevel": 0,

  // 工作台
  "workbench.colorTheme": "One Dark Pro",
  "workbench.iconTheme": "material-icon-theme",
  "workbench.startupEditor": "none",
  "workbench.editor.enablePreview": false,
  "workbench.tree.indent": 16,

  // 终端
  "terminal.integrated.fontSize": 13,
  "terminal.integrated.fontFamily": "JetBrains Mono",
  "terminal.integrated.defaultProfile.osx": "zsh",

  // 文件
  "files.autoSave": "onFocusChange",
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "files.trimFinalNewlines": true,
  "files.exclude": {
    "**/.git": true,
    "**/.DS_Store": true,
    "**/node_modules": true,
    "**/.next": true
  },

  // 搜索
  "search.exclude": {
    "**/node_modules": true,
    "**/pnpm-lock.yaml": true,
    "**/.next": true
  },

  // 语言特定设置
  "[typescript]": {
    "editor.defaultFormatter": "biomejs.biome"
  },
  "[typescriptreact]": {
    "editor.defaultFormatter": "biomejs.biome"
  },
  "[javascript]": {
    "editor.defaultFormatter": "biomejs.biome"
  },
  "[javascriptreact]": {
    "editor.defaultFormatter": "biomejs.biome"
  },
  "[json]": {
    "editor.defaultFormatter": "biomejs.biome"
  },
  "[jsonc]": {
    "editor.defaultFormatter": "biomejs.biome"
  },
  "[python]": {
    "editor.defaultFormatter": "charliermarsh.ruff",
    "editor.formatOnSave": true
  },
  "[go]": {
    "editor.defaultFormatter": "golang.go",
    "editor.formatOnSave": true
  },
  "[markdown]": {
    "editor.wordWrap": "on",
    "editor.quickSuggestions": {
      "other": true,
      "comments": true,
      "strings": true
    }
  },

  // TypeScript
  "typescript.updateImportsOnFileMove.enabled": "always",
  "typescript.suggest.autoImports": true,
  "typescript.preferences.importModuleSpecifier": "relative",

  // Tailwind CSS
  "tailwindCSS.experimental.classRegex": [
    ["cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]"],
    ["cx\\(([^)]*)\\)", "(?:'|\"|`)([^']*)(?:'|\"|`)"]
  ],

  // Git
  "git.autofetch": true,
  "git.confirmSync": false,
  "git.enableSmartCommit": true,

  // Emmet
  "emmet.includeLanguages": {
    "javascript": "javascriptreact",
    "typescript": "typescriptreact"
  }
}
```

### keybindings.json

```json
[
  // 快速打开终端
  {
    "key": "ctrl+`",
    "command": "workbench.action.terminal.toggleTerminal"
  },
  // 切换侧边栏
  {
    "key": "cmd+b",
    "command": "workbench.action.toggleSidebarVisibility"
  },
  // 格式化文档
  {
    "key": "shift+alt+f",
    "command": "editor.action.formatDocument"
  },
  // 重命名符号
  {
    "key": "f2",
    "command": "editor.action.rename"
  },
  // 快速修复
  {
    "key": "cmd+.",
    "command": "editor.action.quickFix"
  },
  // 转到定义
  {
    "key": "f12",
    "command": "editor.action.revealDefinition"
  },
  // 查找引用
  {
    "key": "shift+f12",
    "command": "editor.action.goToReferences"
  }
]
```

---

## Cursor (AI Editor)

> 🔄 **Freemium** ($20/月 Pro) | 📦 Homebrew | [官网](https://cursor.sh)

### Installation

```bash
brew install --cask cursor
```

Cursor 是基于 VS Code 的 AI-first 编辑器，内置 Claude/GPT 集成。

### 核心功能

| 功能 | 快捷键 | 说明 |
|------|--------|------|
| **Cmd+K** | `⌘ K` | 在选中代码上执行 AI 操作 |
| **Cmd+L** | `⌘ L` | 打开 Chat 面板 |
| **Cmd+I** | `⌘ I` | 内联代码生成 |
| **Tab** | `Tab` | 接受 AI 建议 |

### 迁移 VS Code 配置

Cursor 可以直接导入 VS Code 的：
- 扩展
- 设置
- 键绑定
- 主题

---

## Vim/Neovim

### 基础 Vim

> 🆓 **开源免费** | macOS 内置

```bash
# ~/.vimrc
syntax on
set number
set relativenumber
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set cursorline
set mouse=a
set clipboard=unnamed
```

### Neovim (可选)

> 🆓 **开源免费** | 📦 Homebrew | [官网](https://neovim.io)

```bash
brew install neovim

# LazyVim (预配置)
# https://www.lazyvim.org/
```

---

## Project Settings

### .vscode/settings.json

项目级设置，覆盖用户设置：

```json
{
  "editor.tabSize": 2,
  "editor.defaultFormatter": "biomejs.biome",
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.organizeImports.biome": "explicit"
  },
  "typescript.tsdk": "node_modules/typescript/lib",
  "typescript.enablePromptUseWorkspaceTsdk": true
}
```

### .vscode/extensions.json

推荐扩展：

```json
{
  "recommendations": [
    "biomejs.biome",
    "bradlc.vscode-tailwindcss",
    "dbaeumer.vscode-eslint"
  ]
}
```

---

## Tips

### 多光标编辑

- `⌥ + Click` - 添加光标
- `⌘ + D` - 选择下一个相同词
- `⌘ + ⇧ + L` - 选择所有相同词

### 快速导航

- `⌘ + P` - 快速打开文件
- `⌘ + ⇧ + P` - 命令面板
- `⌘ + ⇧ + O` - 跳转到符号
- `⌃ + G` - 跳转到行号

### 代码折叠

- `⌘ + ⌥ + [` - 折叠
- `⌘ + ⌥ + ]` - 展开
- `⌘ + K ⌘ + 0` - 折叠所有
- `⌘ + K ⌘ + J` - 展开所有

---

## 快速安装脚本

```bash
#!/bin/bash
# install-editor.sh

# VS Code
brew install --cask visual-studio-code

# Cursor
brew install --cask cursor

# 核心扩展
code --install-extension biomejs.biome
code --install-extension eamodio.gitlens
code --install-extension usernamehw.errorlens
code --install-extension zhuangtongfa.material-theme
code --install-extension pkief.material-icon-theme

echo "Editor setup complete!"
```

## Next Steps

继续 [07. Vibe Coding](07-vibe-coding.md) 配置 AI 辅助编程工具。
