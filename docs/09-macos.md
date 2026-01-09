# 09. macOS

> 系统优化配置 - 让 Mac 更适合开发

**图例**: 🆓 免费开源 | 💰 付费 | 🔄 Freemium | 📦 Homebrew 可安装

---

## 辅助工具

| 工具 | 说明 | 定价 | 安装方式 |
|------|------|------|----------|
| **ncdu** | 磁盘使用分析 | 🆓 开源免费 | 📦 `brew install ncdu` |

---

## Finder 配置

### 显示设置

```bash
# 显示隐藏文件
defaults write com.apple.finder AppleShowAllFiles -bool true

# 显示所有文件扩展名
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# 显示路径栏
defaults write com.apple.finder ShowPathbar -bool true

# 显示状态栏
defaults write com.apple.finder ShowStatusBar -bool true

# 搜索时默认搜索当前文件夹
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# 禁止在网络驱动器上创建 .DS_Store
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# 禁止在 USB 驱动器上创建 .DS_Store
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# 默认使用列表视图
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# 重启 Finder 使设置生效
killall Finder
```

---

## Dock 配置

```bash
# 自动隐藏 Dock
defaults write com.apple.dock autohide -bool true

# 减少 Dock 隐藏延迟
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.3

# 设置 Dock 图标大小
defaults write com.apple.dock tilesize -int 48

# 禁用最近使用的应用
defaults write com.apple.dock show-recents -bool false

# 最小化窗口效果 (scale 比 genie 更快)
defaults write com.apple.dock mineffect -string "scale"

# 重启 Dock
killall Dock
```

---

## 键盘配置

```bash
# 加快按键重复速度
defaults write NSGlobalDomain KeyRepeat -int 2

# 减少按键重复延迟
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# 禁用自动更正
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# 禁用自动大写
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# 禁用智能引号
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# 禁用智能破折号
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# 禁用长按弹出字符选择 (启用按键重复)
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
```

---

## 触控板配置

```bash
# 启用轻点点击
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# 三指拖拽 (需要在辅助功能中手动启用)
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# 提高触控板跟踪速度
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.0
```

---

## 截图配置

```bash
# 更改截图保存位置
mkdir -p ~/Pictures/Screenshots
defaults write com.apple.screencapture location ~/Pictures/Screenshots

# 更改截图格式 (png, jpg, pdf)
defaults write com.apple.screencapture type -string "png"

# 禁用截图阴影
defaults write com.apple.screencapture disable-shadow -bool true

# 重启服务
killall SystemUIServer
```

---

## Safari 配置 (开发者)

```bash
# 显示开发菜单
defaults write com.apple.Safari IncludeDevelopMenu -bool true

# 启用 Web 检查器
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

# 在所有网页视图中启用 Web 检查器
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
```

---

## 系统性能优化

```bash
# 禁用 Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# 禁用动画效果
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write -g QLPanelAnimationDuration -float 0

# 加快窗口调整大小速度
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# 禁用 Crash Reporter
defaults write com.apple.CrashReporter DialogType -string "none"
```

---

## 安全配置

```bash
# 启用防火墙
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# 启用隐身模式
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on

# 检查 SIP 状态
csrutil status

# 检查 Gatekeeper 状态
spctl --status
```

---

## 隐私配置

```bash
# 禁止发送诊断数据
defaults write com.apple.SubmitDiagInfo AutoSubmit -bool false
defaults write com.apple.SubmitDiagInfo AutoSubmitVersion -int 0
```

---

## 开发者友好设置

```bash
# 在 Xcode 中显示构建时间
defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool true

# 禁止 Time Machine 提示将新硬盘用作备份卷
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# 始终显示用户目录
chflags nohidden ~/Library
```

---

## 完整配置脚本

```bash
#!/bin/bash
# macos-defaults.sh

echo "Configuring macOS defaults..."

# Close System Preferences to prevent conflicts
osascript -e 'tell application "System Preferences" to quit'

# Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Dock
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.3
defaults write com.apple.dock tilesize -int 48
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock mineffect -string "scale"

# Keyboard
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Trackpad
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# Screenshots
mkdir -p ~/Pictures/Screenshots
defaults write com.apple.screencapture location ~/Pictures/Screenshots
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true

# Safari (Dev)
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true

# Performance
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Security
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on

# Restart affected services
killall Finder
killall Dock
killall SystemUIServer

echo "macOS configuration complete!"
echo "Some changes may require logout/restart to take effect."
```

---

## 恢复默认设置

如果需要恢复默认设置：

```bash
# 删除特定设置
defaults delete com.apple.finder AppleShowAllFiles

# 或删除整个 plist
defaults delete com.apple.finder

# 然后重启 Finder
killall Finder
```

---

## 查看当前设置

```bash
# 查看所有 Finder 设置
defaults read com.apple.finder

# 查看特定设置
defaults read com.apple.dock autohide

# 查看全局设置
defaults read NSGlobalDomain
```

---

## Tips

### 重置 Launchpad

```bash
defaults write com.apple.dock ResetLaunchPad -bool true
killall Dock
```

### 清理 DNS 缓存

```bash
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
```

### 重建 Spotlight 索引

```bash
sudo mdutil -E /
```

### 查看磁盘使用

```bash
# 内置命令
du -sh ~/Documents/*

# 或使用 ncdu (🆓 开源免费)
brew install ncdu
ncdu /
```

---

**恭喜！** 你已完成 macOS 开发环境的完整配置。

---

## 验证安装

运行验证脚本确认所有工具已正确安装：

```bash
./scripts/verify.sh
```

---

如需更多帮助，请查看 [故障排除指南](00-troubleshooting.md) 或访问 [GitHub Issues](https://github.com/larrykoo711/new-macos-starter/issues)。
