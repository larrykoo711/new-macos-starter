# Changelog

记录所有面向用户可感知的变更。格式参考 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.1.0/)。

## [Unreleased]

## [0.2.1] - 2026-05-07

### Added — 终端推荐
- **Ghostty**：开源、GPU 加速、Mitchell Hashimoto 出品。新增 cask 到 Brewfile，加入 verify 检测项与 SKILL/packages 注册表
- **tmux**：终端复用器，作为 Ghostty 推荐搭档加入 Brewfile（formula）；docs/02 / docs/08 表格更新为 "Ghostty + tmux" 推荐组合，Warp 降为可选替代

### Removed — 淘汰工具
- **Cursor**：从 Brewfile / SKILL / presets / packages / docs / README 全面移除。AI 编辑器主推 VS Code + Claude Code 扩展组合
- **Notion**：从默认推荐列表移除（用户自行下载即可）
- **Slack / Discord / WhatsApp**：移出默认 Brewfile，文档保留"易于自行下载"说明
- **Apifox**：API 调试工具按团队习惯自选，不再纳入默认
- **LM Studio**：本地大模型运行器按硬件需求自选；Cherry Studio 为更通用的多模型客户端
- **DingTalk / WeCom**：按用户反馈，从默认通讯应用列表移除

### Changed — 编辑器策略
- README / docs/06 / docs/07 / SKILL.md 一致：**VS Code（编辑器）+ Claude Code（CLI/扩展）** 作为推荐 AI 工作流
- VS Code 通过 `code --install-extension anthropic.claude-code` 安装官方 Claude Code 扩展

### Changed — 版本基线
- **Python**：默认 3.12 → **3.13**（已 GA 一年多，生态稳定）；docs/05 同时演示 3.14 作为预览
- **Node.js**：Dockerfile 示例 `node:22-alpine` → **`node:24-alpine`**（Active LTS 至 2028-04）；docs/05 `fnm install` 默认改为 24
- **Go**：goenv 示例 `1.23.9` → **`1.25.1`**；Dockerfile `golang:1.23-alpine` → `golang:1.25-alpine`；SKILL `goenv install latest`（实际不存在的关键字）替换为具体版本
- **Java**：SDKMAN 安装命令从 `<full-version>-amzn` 改为 `<major>-amzn`（自动取最新 patch，降低文档维护成本）

## [0.2.0] - 2026-05-07

### Added — 经验沉淀
- **Shell**：`configs/shell/.zshrc` 新增 `clash()` / `clash_off()` 语义代理函数；`PROXY_PORT` 环境变量支持自定义端口
- **Shell**：`libpq` PATH 块（arm64/intel 条件分支，解决 keg-only 找不到 `psql` 的坑）
- **Shell**：`KUBECONFIG` 多集群动态合并（自动扫描 `~/.kube/configs/*.yaml`）
- **Shell**：`java_switch <major>` 通用 Java 版本切换函数；保留 `java11/17/21` 兼容别名
- **Shell**：goenv shims 强制 PATH 前置注释（解决 air 热重载找不到 go 的坑）
- **Git**：`configs/git/commit-template.txt`（Conventional Commits + 中文 type 速查）
- **npm**：`configs/npm/.npmrc`（默认 npmjs.org，注释提供 npmmirror.com 切换）
- **Brewfile**：新增 `google-cloud-sdk` / `vercel-cli` / `stripe-cli` / `1password-cli`

### Added — AI 自动化
- **`scripts/install-dotfiles.sh`**：一键 symlink `configs/` → `~`，自动备份 `.bak.<时间戳>`，支持 `--dry-run` / `--force`
- **`scripts/macos-defaults.sh`**：从 docs/09 提取，支持 `--list` / `--category <name>` / `--all` / `--dry-run`，8 个分类（finder/dock/keyboard/trackpad/screenshot/safari/performance/developer）
- **`scripts/verify.sh --json`**：机器可读 JSON 输出（含 score、results、版本号）
- **`/health-check`** 新命令：解析 verify JSON，按 Critical/Recommended/Optional 分级输出修复命令
- **SKILL.md Phase 9**：Config Deployment 阶段 — AI 自动调用 `install-dotfiles.sh` 部署配置
- **SKILL.md TodoWrite**：所有 Phase 的进度通过 TodoWrite 实时跟踪

### Added — Claude Code 模板
- **`configs/claude/settings.json`**：精选权限模板（7 官方插件、60+ Bash/WebFetch 白名单、保守的 `defaultMode: default`）
- 模板严格脱敏：移除私有 skill 引用、本机 statusLine 路径、`bypassPermissions`

### Added — 文档
- **`docs/10-network-china.md`**：中国网络环境完整指南（Clash、Homebrew/npm/Go/pip 镜像、一键模式切换）
- **`docs/05-dev-environment.md`**：补 `KUBECONFIG 多集群合并` 与 `Java 多版本管理` 章节
- **`docs/07-vibe-coding.md`**：补 `Claude Code 配置模板` 章节；替换原有 XXX 占位符
- **`ROADMAP.md`**：声明 v0.3+ 演进方向
- **`CHANGELOG.md`**：当前文件

### Changed
- `verify.sh`：检测项从 27 项扩展到 34 项（含云 CLI、KUBECONFIG、`.zshrc` symlink 状态）
- `CLAUDE.md`：补 Phase 9 / install-dotfiles.sh / macos-defaults.sh 的执行流说明

### Fixed
- `docs/07-vibe-coding.md`：替换 2 处 `XXX` 占位符为具体示例

## [0.1.0] - 2026-04-22

### Added
- 初始版本：bootstrap.sh + verify.sh + Brewfile（80+ 包）
- 9 章中文文档（约 3900 行）
- 5 角色预设（fullstack / frontend / backend / data / devops）
- AI 安装向导：`.claude/skills/macos-setup/SKILL.md`（581 行） + `/new-macos-setup` 命令
- 中英双语 README

[Unreleased]: https://github.com/larrykoo711/new-macos-starter/compare/v0.2.1...HEAD
[0.2.1]: https://github.com/larrykoo711/new-macos-starter/compare/v0.2.0...v0.2.1
[0.2.0]: https://github.com/larrykoo711/new-macos-starter/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/larrykoo711/new-macos-starter/releases/tag/v0.1.0
