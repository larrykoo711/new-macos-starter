---
description: Run verify.sh in JSON mode and return AI-curated fix commands for missing tools
allowed-tools: Bash(./scripts/verify.sh:*), Read(**), Write(**)
argument-hint: [--apply]
---

# macOS Starter - Health Check

> 运行 `verify.sh --json` 收集环境状态，按缺失工具的影响分级（Critical / Recommended / Optional）输出可执行的修复命令。

## Usage

```bash
/health-check          # 列出缺失工具 + 修复建议
/health-check --apply  # 询问确认后逐个执行修复（NOT 实现于 v0.2，仅占位）
```

## Execution Steps

### Step 1: 收集 JSON 报告

```bash
./scripts/verify.sh --json > /tmp/macos-starter-health.json
```

### Step 2: 解析 missing 条目

用 Read 工具读取 `/tmp/macos-starter-health.json`，提取 `results[*]` 中 `status == "missing"` 的条目。**不依赖 jq**（保证用户机器无 jq 时也能跑）— 直接 Read JSON 文本，AI 自己解析结构。

### Step 3: 查找安装命令

针对每个缺失项，按以下顺序查找其安装命令：

1. **CLI 工具**：参考 `.claude/skills/macos-setup/packages.md`
2. **应用**：用 `brew install --cask <name>`，参考 `scripts/Brewfile`
3. **配置缺失**（如 `.zshrc symlink`、`KUBECONFIG`）：给出 `scripts/install-dotfiles.sh` / 配置文件创建指引

### Step 4: 分级输出

按以下分级生成报告：

```markdown
## 🔴 Critical（影响开发链，必须修复）
- Homebrew: `bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
- Git: `xcode-select --install`
- Node.js: 见 `fnm` 安装

## 🟡 Recommended（强烈建议）
- starship: `brew install starship`
- delta: `brew install git-delta`

## 🟢 Optional（按需）
- 1Password CLI (op): `brew install 1password-cli`
- Stripe CLI: `brew install stripe/stripe-cli/stripe`

## 📋 一键安装（复制粘贴）

\`\`\`bash
brew install starship git-delta 1password-cli
brew install --cask raycast
\`\`\`
```

### Step 5: 配置类缺失的特殊处理

| 缺失项 | 修复命令 |
|---|---|
| `.zshrc symlink` | `./scripts/install-dotfiles.sh --dry-run && ./scripts/install-dotfiles.sh` |
| `KUBECONFIG` | 建议用户把集群配置放到 `~/.kube/configs/*.yaml`，重新 `source ~/.zshrc` |
| `Starship config` | `./scripts/install-dotfiles.sh` 会自动创建 symlink |
| `Oh-My-Zsh` | `sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"` |

## Critical 工具清单

以下工具被认为是开发链的**关键依赖**，缺失即归 Critical：

- `brew`, `git`, `node`/`fnm`, `python3`/`uv`, `gh`

其他全部归 Recommended 或 Optional（应用类默认 Optional）。

## Output Format Guidelines

- 用中文输出（项目语言约定）
- 每条修复命令必须可直接复制粘贴执行
- 末尾给出 `一键安装` 段，把同一类（brew CLI、cask、配置脚本）的命令打包
- 如果 `score.percent >= 90` 且无 Critical 缺失，直接显示 "🎉 环境就绪，无需修复"
- 如果 `verify.sh --json` 执行失败（脚本不存在或权限错误），提示用户运行 `chmod +x scripts/verify.sh` 后重试

## Related Files

- `scripts/verify.sh` — 数据源
- `.claude/skills/macos-setup/packages.md` — 包注册表
- `scripts/Brewfile` — Homebrew 包定义
- `scripts/install-dotfiles.sh` — 配置类缺失的统一修复入口
