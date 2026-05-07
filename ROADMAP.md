# Roadmap

仓库长期演进方向。已发布详见 [CHANGELOG.md](CHANGELOG.md)。

## v0.3（计划中）

### 同步与可移植性
- [ ] **多机同步**：基于 Git + iCloud 的双向 dotfiles 同步（保留个人覆盖层 `~/.zshrc.local`）
- [ ] **Brewfile lock**：固定包版本（`brew bundle dump --describe --no-vscode --file=Brewfile.lock`）

### AI 自动化深化
- [ ] **自定义预设加载**：`~/.macos-starter.yml` 用户文件覆盖 5 个内置预设
- [ ] **`/health-check --apply`**：从修复建议直接执行（前置确认）
- [ ] **release-please**：main 合并自动维护 CHANGELOG 与 git tag

### 工具链扩展
- [ ] **VSCode/Cursor 扩展自动安装**：`code --install-extension <id>` 列表
- [ ] **Karabiner-Elements 模板**：`configs/karabiner/karabiner.json`（Caps→Hyper、Cmd 双击等）
- [ ] **Ghostty 配置模板**：`configs/terminal/ghostty.config`

### 企业场景
- [ ] **MDM 集成方案**：在企业 macOS 设备上零接触部署
- [ ] **离线包**：预下载 Homebrew bottles 用于无网/弱网环境

## v0.4+（远期）

- [ ] **跨平台镜像**：Linux 子项目（保持 90% 配置共享）
- [ ] **AI 错误诊断 skill**：`/diagnose <error>` 用 AI 解读 brew/npm/git 错误
- [ ] **可视化进度**：`/new-macos-setup` 在 Claude Code 中实时显示安装进度图

## 设计原则

无论 roadmap 怎么变，以下不变：

1. **Ship Fast. Break Things. Fix Faster.**：小步快跑而非大版本
2. **可逆性优先**：所有自动化操作必须支持 dry-run 与备份
3. **本机经验回流**：长期使用沉淀的踩坑经验持续回流到模板
4. **AI-native**：`/new-macos-setup`、`/health-check` 等 skill 是一等公民

## 提需求

欢迎在 GitHub Issues 用 `feature request` 模板提交想法。优先实现：
- 解决多人共同的痛点
- 不破坏向后兼容
- 能在 1 个 stage 内完成
