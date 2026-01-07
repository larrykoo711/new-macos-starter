# 06. Editor

> 代码编辑器配置 - 生产力核心

## VS Code

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

## Essential Extensions

### 核心扩展

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

```bash
# One Dark Pro
code --install-extension zhuangtongfa.material-theme

# Material Icon Theme
code --install-extension pkief.material-icon-theme

# GitHub Theme
code --install-extension github.github-vscode-theme
```

### 生产力

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

```bash
# GitHub Copilot
code --install-extension github.copilot

# Codeium (免费替代)
code --install-extension codeium.codeium
```

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

## Cursor (AI Editor)

### Installation

```bash
brew install --cask cursor
```

Cursor 是基于 VS Code 的 AI-first 编辑器，内置 Claude/GPT 集成。

### 迁移 VS Code 配置

Cursor 可以直接导入 VS Code 的：
- 扩展
- 设置
- 键绑定
- 主题

## Vim/Neovim

### 基础 Vim

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

```bash
brew install neovim

# LazyVim (预配置)
# https://www.lazyvim.org/
```

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

## Next Steps

继续 [07. Vibe Coding](07-vibe-coding.md) 配置 AI 辅助编程工具。
