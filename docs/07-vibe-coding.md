# 07. Vibe Coding

> AI 辅助编程 - 让 AI 成为你的结对编程伙伴

## What is Vibe Coding?

Vibe Coding 是一种全新的编程范式，通过与 AI 对话来完成编码任务：

- **自然语言驱动** - 用自然语言描述需求，AI 生成代码
- **上下文感知** - AI 理解整个项目结构和代码库
- **迭代优化** - 通过对话不断改进代码
- **学习加速** - 在实践中学习最佳实践

---

## 工具总览

| 工具 | 类型 | 定价 | 安装方式 |
|------|------|------|----------|
| [Claude Code](#claude-code) | Terminal CLI（推荐主力） | 🔄 API 付费 | 📦 `brew install --cask claude-code` |
| [VS Code](../docs/06-editor.md) | GUI Editor（推荐配合 Claude Code） | 🆓 免费 | 📦 `brew install --cask visual-studio-code` |
| [OpenCode](#opencode) | Terminal CLI | 🆓 开源 + API 付费 | 📦 `brew install opencode` |
| [CCometixLine](#ccometixline) | CLI 增强 | 🆓 开源免费 | `npm install -g @cometix/ccline` |
| [Cherry Studio](#cherry-studio) | GUI Client | 🆓 开源免费 | 📦 `brew install --cask cherry-studio` |

**图例**: 🆓 免费开源 | 💰 付费 | 🔄 Freemium | 📦 Homebrew 可安装

---

## 核心工具

### Claude Code

> 🔄 **Freemium** (需 Anthropic API) | 📦 Homebrew | [官网](https://claude.ai/claude-code)

Anthropic 官方 CLI 工具，直接在终端中与 Claude 交互。

#### 安装

```bash
# 方式 1: Homebrew Cask (推荐)
brew install --cask claude-code

# 方式 2: 原生安装脚本
curl -fsSL https://claude.ai/install.sh | bash
```

#### 配置

```bash
# 登录认证
claude login

# 查看版本
claude --version
```

#### 常用命令

```bash
# 启动交互会话
claude

# 在当前目录启动 (推荐)
claude .

# 继续上次会话
claude --continue

# 非交互模式
claude -p "解释这个函数的作用"

# 指定模型
claude --model claude-sonnet-4-20250514
```

#### CLAUDE.md 配置

在项目根目录创建 `CLAUDE.md` 文件，定义项目上下文：

```markdown
# Project Context

## 技术栈
- 前端: React + TypeScript + Tailwind
- 后端: Go + Gin
- 数据库: PostgreSQL

## 代码规范
- 使用 pnpm 管理依赖
- 使用 Biome 格式化代码
- 遵循 Conventional Commits

## 常用命令
- `pnpm dev` - 启动开发服务器
- `pnpm test` - 运行测试
- `pnpm build` - 构建生产版本
```

---

### VS Code（推荐 GUI 配合 Claude Code）

不再单独推荐 Cursor。原因：

- **Claude Code** 在 CLI 即可完成 95% 的 AI 工程任务
- **VS Code** + **Claude Code 扩展** 组合零成本、生态最广、扩展自由
- 项目级提示词通过 `CLAUDE.md` 沉淀（与 IDE 无关），可跨工具复用

```bash
brew install --cask visual-studio-code claude-code

# VS Code 中安装 Claude Code 官方扩展
code --install-extension anthropic.claude-code
```

VS Code 详细配置见 [06. Editor](06-editor.md)。

---

### OpenCode

> 🆓 **开源免费** (需 API Key) | 📦 Homebrew | [GitHub](https://github.com/opencode-ai/opencode)

开源的终端 AI 编程助手，使用 Go 构建。支持多种 LLM 提供商。

#### 安装

```bash
# 使用 Homebrew
brew install opencode

# 或使用 Go
go install github.com/opencode-ai/opencode@latest
```

#### 启动

```bash
# 在项目目录启动
opencode

# 指定模型
opencode --model anthropic/claude-sonnet-4-20250514
```

#### 配置

创建 `~/.opencode/config.yaml`:

```yaml
# 默认模型
default_model: anthropic/claude-sonnet-4-20250514

# API 配置
providers:
  anthropic:
    api_key: ${ANTHROPIC_API_KEY}
  openai:
    api_key: ${OPENAI_API_KEY}

# 主题
theme: dark

# 自动保存
auto_save: true
```

---

### CCometixLine

> 🆓 **开源免费** | npm | [GitHub](https://github.com/Haleclipse/CCometixLine)

Claude Code 的 statusline 增强工具，使用 Rust 构建，提供 Git 集成和上下文显示。

#### 安装

```bash
# 需要 Node.js
npm install -g @cometix/ccline
```

#### 配置

编辑 `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "ccline",
    "padding": 0
  }
}
```

或使用 TUI 配置界面:

```bash
ccline config
```

#### 功能

- Git 分支和仓库状态显示
- 当前 Claude 模型名称
- 上下文窗口使用率百分比
- 工作目录路径

---

### Cherry Studio

> 🆓 **开源免费** | 📦 Homebrew | [GitHub](https://github.com/kangfenmao/cherry-studio)

多模型 AI 桌面客户端，支持多种 LLM 服务商。跨平台支持 macOS/Windows/Linux。

#### 安装

```bash
brew install --cask cherry-studio
```

#### 功能

- 支持 OpenAI, Anthropic, Google 等多种模型
- 本地模型支持 (Ollama)
- 对话历史管理
- 多会话支持

---

## 最佳实践

### 1. 项目上下文

始终提供清晰的项目上下文：

```markdown
# CLAUDE.md（IDE 无关，所有 AI 工具都能读）

## 项目简介
（一句话说明系统是什么、面向谁、解决什么问题，例如：
"面向小型团队的任务追踪 SaaS，支持看板视图与日报自动汇总"）

## 技术栈
- 语言: TypeScript/Go/Python
- 框架: React/Gin/FastAPI
- 数据库: PostgreSQL/MongoDB

## 目录结构
src/
├── components/  # UI 组件
├── hooks/       # 自定义 Hooks
├── services/    # API 服务
└── utils/       # 工具函数

## 编码规范
- 风格：函数式优先；副作用集中在 services 层；UI 组件不直接调 API
- 命名：变量/函数 camelCase；类型/组件 PascalCase；常量 UPPER_SNAKE
- 注释：仅在意图非显而易见时写「为什么」；不写「做什么」（看代码即可）
```

### 2. 高效提示词

**具体明确**:
```
❌ "帮我写个登录功能"
✅ "创建一个 React 登录表单组件，包含邮箱和密码字段，
   使用 React Hook Form 验证，提交后调用 /api/auth/login"
```

**提供上下文**:
```
❌ "修复这个 bug"
✅ "这个函数在处理空数组时会抛出异常，请添加空值检查，
   并返回空数组而不是 undefined"
```

**分步骤**:
```
1. 首先，分析现有的用户认证流程
2. 然后，设计新的 OAuth 集成方案
3. 最后，实现 Google 登录功能
```

### 3. 代码审查流程

```bash
# 使用 Claude Code 审查代码
claude -p "审查这个 PR 的代码改动，关注：
1. 潜在的 bug 和边界情况
2. 性能问题
3. 安全漏洞
4. 代码可读性"

# 在 VS Code 中（安装 Claude Code 扩展后）
# 选中代码 → 命令面板 → "Claude: Review selection"
```

### 4. 测试生成

```bash
# Claude Code
claude -p "为 src/utils/validator.ts 生成单元测试，
使用 Vitest，覆盖所有边界情况"
```

---

## 工具对比

| 特性 | Claude Code | OpenCode | Cherry Studio |
|------|-------------|----------|---------------|
| **界面** | Terminal | Terminal | GUI 客户端 |
| **模型** | Claude 系列 | 多模型支持 | 多模型支持 |
| **代码库理解** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| **适用场景** | 命令行/Agent 工程化 | 开源替代 | 多模型对话 |
| **定价** | 🔄 API 付费 | 🆓 + API | 🆓 免费 |
| **离线支持** | ❌ | ❌ | ✅ (本地模型) |
| **开源** | ❌ | ✅ | ✅ |

### 使用建议

| 工具 | 最佳用例 |
|------|----------|
| **Claude Code（推荐主力）** | 工程开发、DevOps、代码审查、Agent 模式 |
| **VS Code（推荐 GUI 配合 Claude Code）** | 日常编辑、调试、扩展生态 |
| **OpenCode** | 想要开源替代方案、自定义需求、多模型切换 |
| **Cherry Studio** | 多模型对比测试、本地模型使用、非开发人员 |

---

## 环境变量配置

```bash
# ~/.zshrc

# Anthropic API
export ANTHROPIC_API_KEY="sk-ant-xxx"

# OpenAI API（OpenCode/Cherry Studio 等可选）
export OPENAI_API_KEY="sk-xxx"

# 可选: 使用代理
export HTTPS_PROXY="http://127.0.0.1:7890"
```

---

## 安全注意事项

1. **API Key 保护**
   - 不要将 API Key 提交到 Git
   - 使用环境变量或密钥管理工具

2. **敏感代码**
   - 避免将敏感业务逻辑发送给 AI
   - 注意代码中的密钥和凭证

3. **代码审查**
   - AI 生成的代码需要人工审查
   - 不要盲目接受所有建议

---

## 快速安装

```bash
#!/bin/bash
# install-vibe-coding.sh

# Claude Code + VS Code（推荐组合）
brew install --cask claude-code visual-studio-code

# Claude Code 官方 VS Code 扩展（自动同步会话）
code --install-extension anthropic.claude-code

# OpenCode (可选)
# brew install opencode

# Cherry Studio (可选)
# brew install --cask cherry-studio

echo "Vibe Coding tools installed!"
echo ""
echo "Next steps:"
echo "  1. Run 'claude login' to authenticate"
echo "  2. Create CLAUDE.md in your projects"
echo "  3. Copy ~/.claude/settings.json from configs/claude/settings.json"
```

---

## Claude Code 配置模板（v0.2 NEW）

仓库提供了一份精选的 `~/.claude/settings.json` 模板：`configs/claude/settings.json`。

### 它做了什么

- 启用 7 个常用官方插件（code-review、commit-commands、context7、feature-dev、frontend-design、pr-review-toolkit、superpowers）
- 预授权 60+ 条 Bash/WebFetch 权限，避免日常开发被反复弹窗打断
- 默认 `permissions.defaultMode: default`（首次询问），熟悉后可改为 `acceptEdits`
- 开启 `effortLevel: high` + `language: Chinese`

### 部署方法

```bash
# 不做 symlink（Claude Code 有自己的 settings 层级，symlink 可能引发权限问题）
cp configs/claude/settings.json ~/.claude/settings.json
```

### 必改字段

| 字段 | 默认 | 何时改 |
|------|------|--------|
| `language` | `Chinese` | 改成 `English` 或其他工作语言 |
| `outputStyle` | `default` | 想要更专业的工程师风格改成 `engineer-professional` |
| `enabledPlugins` | 7 个插件 | 不需要某个插件就删掉对应键 |
| `statusLine` | 未启用 | 安装 CCometixLine 后参考 `_statusLine_example` 启用 |

### 安全注意

- **不要把私有 settings 提交到公共仓库**：模板是脱敏后的，本机使用习惯可能附带敏感 skill 引用或路径
- **不要默认启用 `bypassPermissions`**：仅在受信仓库的隔离 worktree 中临时启用
- 共享/演示场景：使用 `permissions.defaultMode: default` 而非 `auto`

---

## 资源链接

- [Claude Code 官方文档](https://docs.anthropic.com/claude-code)
- [VS Code 官网](https://code.visualstudio.com)
- [OpenCode GitHub](https://github.com/opencode-ai/opencode)
- [Anthropic Prompt Engineering](https://docs.anthropic.com/claude/docs/prompt-engineering)

## Next Steps

继续 [08. Apps](08-apps.md) 安装推荐应用。
