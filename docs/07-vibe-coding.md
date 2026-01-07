# 07. Vibe Coding

> AI 辅助编程 - 让 AI 成为你的结对编程伙伴

## What is Vibe Coding?

Vibe Coding 是一种全新的编程范式，通过与 AI 对话来完成编码任务：

- **自然语言驱动** - 用自然语言描述需求，AI 生成代码
- **上下文感知** - AI 理解整个项目结构和代码库
- **迭代优化** - 通过对话不断改进代码
- **学习加速** - 在实践中学习最佳实践

## 核心工具

### Claude Code

Anthropic 官方 CLI 工具，直接在终端中与 Claude 交互。

#### 安装

```bash
# 使用 npm 安装
npm install -g @anthropic-ai/claude-code

# 或使用 Homebrew
brew install claude
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

### Cursor

AI-first 代码编辑器，基于 VS Code 构建。

#### 安装

```bash
brew install --cask cursor
```

#### 核心功能

| 功能 | 快捷键 | 说明 |
|------|--------|------|
| **Cmd+K** | `⌘ K` | 在选中代码上执行 AI 操作 |
| **Cmd+L** | `⌘ L` | 打开 Chat 面板 |
| **Cmd+I** | `⌘ I` | 内联代码生成 |
| **Tab** | `Tab` | 接受 AI 建议 |

#### 配置建议

```json
// settings.json
{
  "cursor.cpp.disabledLanguages": [],
  "cursor.general.enableAIReview": true,
  "cursor.general.gitEnabled": true,

  // 使用 Claude 模型
  "cursor.aiModel": "claude-sonnet-4-20250514",

  // 启用 Agent 模式
  "cursor.agent.enabled": true
}
```

#### .cursorrules 配置

在项目根目录创建 `.cursorrules` 文件：

```
You are an expert in TypeScript, React, and Tailwind CSS.

Code Style:
- Use functional components with hooks
- Prefer const over let
- Use early returns for better readability
- Follow the DRY principle

Naming:
- Components: PascalCase
- Functions: camelCase
- Constants: SCREAMING_SNAKE_CASE

Testing:
- Write tests for all new features
- Use Vitest for unit tests
- Use Playwright for E2E tests
```

---

### OpenCode

开源的终端 AI 编程助手，使用 Go 构建。

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

## 最佳实践

### 1. 项目上下文

始终提供清晰的项目上下文：

```markdown
# CLAUDE.md / .cursorrules

## 项目简介
这是一个 XXX 系统，用于 XXX 功能

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
- 使用 XXX 风格
- 命名规范
- 注释要求
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

# 在 Cursor 中
# 选中代码 → Cmd+K → "review this code for potential issues"
```

### 4. 测试生成

```bash
# Claude Code
claude -p "为 src/utils/validator.ts 生成单元测试，
使用 Vitest，覆盖所有边界情况"

# Cursor
# 选中函数 → Cmd+K → "generate comprehensive tests"
```

---

## 工具对比

| 特性 | Claude Code | Cursor | OpenCode |
|------|-------------|--------|----------|
| **界面** | Terminal | GUI (VS Code) | Terminal |
| **模型** | Claude 系列 | 多模型支持 | 多模型支持 |
| **代码库理解** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| **适用场景** | 命令行/DevOps | 日常开发 | 开源替代 |
| **定价** | API 付费 | 订阅制 | API 付费 |
| **离线支持** | ❌ | ❌ | ❌ |

### 使用建议

- **Claude Code**: 适合终端重度用户、DevOps 任务、代码审查
- **Cursor**: 适合日常开发、需要 IDE 完整体验
- **OpenCode**: 适合想要开源替代方案、自定义需求

---

## 环境变量配置

```bash
# ~/.zshrc

# Anthropic API
export ANTHROPIC_API_KEY="sk-ant-xxx"

# OpenAI API (用于 Cursor/OpenCode)
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

# Claude Code
npm install -g @anthropic-ai/claude-code

# Cursor
brew install --cask cursor

# OpenCode
brew install opencode

echo "Vibe Coding tools installed!"
echo ""
echo "Next steps:"
echo "  1. Run 'claude login' to authenticate"
echo "  2. Create CLAUDE.md in your projects"
echo "  3. Configure .cursorrules for Cursor"
```

---

## 资源链接

- [Claude Code 官方文档](https://docs.anthropic.com/claude-code)
- [Cursor 官网](https://cursor.sh)
- [OpenCode GitHub](https://github.com/opencode-ai/opencode)
- [Anthropic Prompt Engineering](https://docs.anthropic.com/claude/docs/prompt-engineering)

## Next Steps

继续 [08. Apps](08-apps.md) 安装推荐应用。
