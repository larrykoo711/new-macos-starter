# 04. Fonts

> 编程字体 - 代码可读性的基础

**图例**: 🆓 免费开源 | 💰 付费 | 🔄 Freemium | 📦 Homebrew 可安装

---

## 推荐字体

| 字体 | 来源 | 定价 | 安装方式 |
|------|------|------|----------|
| **JetBrains Mono** | JetBrains | 🆓 开源免费 | 📦 `brew install --cask font-jetbrains-mono` |
| **Fira Code** | Mozilla | 🆓 开源免费 | 📦 `brew install --cask font-fira-code` |
| **Source Code Pro** | Adobe | 🆓 开源免费 | 📦 `brew install --cask font-source-code-pro` |
| **Hack** | Source Foundry | 🆓 开源免费 | 📦 `brew install --cask font-hack` |
| **Cascadia Code** | Microsoft | 🆓 开源免费 | 📦 `brew install --cask font-cascadia-code` |
| **Meslo** | André Berg | 🆓 开源免费 | 📦 `brew install --cask font-meslo-lg-nerd-font` |

---

### JetBrains Mono (首选)

> 🆓 **开源免费** | 📦 Homebrew | [官网](https://www.jetbrains.com/lp/mono/)

专为开发者设计，支持连字特性。

```bash
# 安装标准版
brew install --cask font-jetbrains-mono

# 安装 Nerd Font 版本 (包含图标)
brew install --cask font-jetbrains-mono-nerd-font
```

特点：
- 专为代码阅读优化
- 支持连字 (Ligatures)
- Nerd Font 版本包含图标
- 免费开源

### Fira Code

> 🆓 **开源免费** | 📦 Homebrew | [GitHub](https://github.com/tonsky/FiraCode)

Mozilla 推出的编程字体，连字支持出色。

```bash
brew install --cask font-fira-code
brew install --cask font-fira-code-nerd-font
```

### Source Code Pro

> 🆓 **开源免费** | 📦 Homebrew | [GitHub](https://github.com/adobe-fonts/source-code-pro)

Adobe 出品，经典选择。

```bash
brew install --cask font-source-code-pro
```

### Hack

> 🆓 **开源免费** | 📦 Homebrew | [官网](https://sourcefoundry.org/hack/)

清晰易读的等宽字体。

```bash
brew install --cask font-hack
brew install --cask font-hack-nerd-font
```

### Cascadia Code

> 🆓 **开源免费** | 📦 Homebrew | [GitHub](https://github.com/microsoft/cascadia-code)

Microsoft 出品，Windows Terminal 默认字体。

```bash
brew install --cask font-cascadia-code
brew install --cask font-cascadia-code-nf
```

### Meslo (Powerline)

> 🆓 **开源免费** | 📦 Homebrew | [GitHub](https://github.com/andreberg/Meslo-Font)

基于 Apple Menlo 的改进版。

```bash
brew install --cask font-meslo-lg-nerd-font
```

---

## Nerd Fonts

> 🆓 **开源免费** | [官网](https://www.nerdfonts.com)

Nerd Fonts 是在原有字体基础上添加了开发相关图标的字体。

### 为什么需要 Nerd Fonts

- 终端图标显示 (文件类型、Git 状态等)
- Oh-My-Zsh 主题支持
- Starship prompt 图标
- Vim/Neovim 插件图标

### 安装

```bash
# 安装常用 Nerd Fonts
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-fira-code-nerd-font
brew install --cask font-hack-nerd-font
brew install --cask font-meslo-lg-nerd-font
```

---

## 配置

### VS Code

```json
{
  "editor.fontFamily": "JetBrains Mono, Menlo, Monaco, 'Courier New', monospace",
  "editor.fontSize": 14,
  "editor.fontLigatures": true,
  "editor.lineHeight": 1.6,
  "terminal.integrated.fontFamily": "JetBrainsMonoNerdFont"
}
```

### iTerm2

1. Preferences → Profiles → Text
2. Font → JetBrainsMono Nerd Font
3. Size → 14
4. Use ligatures → ✓

### Terminal.app

1. Preferences → Profiles → Text
2. Font → Change → JetBrains Mono
3. Size → 14

### Cursor

与 VS Code 相同配置。

---

## 连字 (Ligatures)

连字将多个字符组合显示为单个符号，提高代码可读性。

常见连字：

| 字符 | 连字效果 |
|------|---------|
| `->` | → |
| `=>` | ⇒ |
| `!=` | ≠ |
| `===` | ≡ |
| `>=` | ≥ |
| `<=` | ≤ |
| `||` | ‖ |
| `&&` | ∧ |

### 启用连字

VS Code:
```json
{
  "editor.fontLigatures": true
}
```

### 禁用特定连字

如果只想禁用部分连字：

```json
{
  "editor.fontLigatures": "'calt' off"
}
```

---

## 字体选择建议

### 按场景

| 场景 | 推荐字体 |
|------|---------|
| 日常编码 | JetBrains Mono |
| 终端 | JetBrainsMono Nerd Font |
| 演示/分享 | Fira Code |
| 长时间阅读 | Source Code Pro |

### 按编程语言

| 语言 | 推荐 |
|------|------|
| JavaScript/TypeScript | JetBrains Mono (连字) |
| Python | Source Code Pro |
| Go | JetBrains Mono |
| Rust | Fira Code |

---

## 中文字体搭配

### 推荐组合

```json
{
  "editor.fontFamily": "JetBrains Mono, 'PingFang SC', 'Noto Sans CJK SC', sans-serif"
}
```

### 安装中文字体

| 字体 | 说明 | 定价 | 安装方式 |
|------|------|------|----------|
| **Noto Sans CJK SC** | Google 思源黑体 | 🆓 开源免费 | 📦 `brew install --cask font-noto-sans-cjk-sc` |
| **Sarasa Gothic** | 更纱黑体 (等宽中英文) | 🆓 开源免费 | 📦 `brew install --cask font-sarasa-gothic` |
| **Inter** | 现代 UI 字体 | 🆓 开源免费 | 📦 `brew install --cask font-inter` |

```bash
# Noto Sans CJK
brew install --cask font-noto-sans-cjk-sc

# 更纱黑体 (等宽中英文)
brew install --cask font-sarasa-gothic
```

---

## 字体大小建议

### 按屏幕分辨率

| 屏幕 | 推荐大小 |
|------|---------|
| 13" MacBook | 13-14 |
| 14" MacBook Pro | 14-15 |
| 16" MacBook Pro | 14-16 |
| 外接 4K 显示器 | 14-16 |

### 按视力/距离

- 近距离 (<50cm): 13-14
- 正常距离 (50-70cm): 14-15
- 远距离 (>70cm): 15-16

---

## 快速安装脚本

```bash
#!/bin/bash
# install-fonts.sh

# 安装编程字体
brew install --cask font-jetbrains-mono
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-fira-code
brew install --cask font-fira-code-nerd-font
brew install --cask font-source-code-pro
brew install --cask font-hack-nerd-font
brew install --cask font-meslo-lg-nerd-font

# 安装中文字体
brew install --cask font-noto-sans-cjk-sc

echo "Fonts installed successfully!"
```

## 验证安装

```bash
# 列出已安装的字体
fc-list | grep -i "JetBrains"

# 或在 Font Book.app 中查看
open -a "Font Book"
```

## Next Steps

继续 [05. Dev Environment](05-dev-environment.md) 配置开发环境。
