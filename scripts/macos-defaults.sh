#!/bin/bash
#
# macOS Starter - macOS Defaults Configuration
# 应用 macOS 系统优化（Finder / Dock / 键盘 / 截图 等）。支持分类执行 + dry-run。
#
# Usage:
#   ./scripts/macos-defaults.sh --list                   # 列出所有 category
#   ./scripts/macos-defaults.sh --category dock          # 只跑 dock
#   ./scripts/macos-defaults.sh --all                    # 全部应用（前置确认）
#   ./scripts/macos-defaults.sh --all --dry-run          # 预览所有命令
#

set -euo pipefail

CATEGORIES=(finder dock keyboard trackpad screenshot safari performance developer)

DRY_RUN=false
SELECTED=""
RUN_ALL=false
NO_CONFIRM=false

usage() {
    head -12 "$0" | tail -10
    echo
    echo "Categories: ${CATEGORIES[*]}"
}

# 参数解析
while [[ $# -gt 0 ]]; do
    case "$1" in
        --dry-run)    DRY_RUN=true ;;
        --all)        RUN_ALL=true ;;
        --yes|-y)     NO_CONFIRM=true ;;
        --category)   SELECTED="${2:-}"; shift ;;
        --list)
            echo "Available categories:"
            for c in "${CATEGORIES[@]}"; do echo "  - $c"; done
            exit 0
            ;;
        -h|--help)    usage; exit 0 ;;
        *)            echo "Unknown flag: $1"; usage; exit 1 ;;
    esac
    shift
done

if [[ -z "$SELECTED" ]] && ! $RUN_ALL; then
    usage
    exit 1
fi

# 工具函数：执行或打印
run() {
    if $DRY_RUN; then
        echo "  [dry-run] $*"
    else
        eval "$@"
    fi
}

# 工具函数：分类标题
section() {
    echo
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  $1"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# === Categories ===

cat_finder() {
    section "Finder"
    run 'defaults write com.apple.finder AppleShowAllFiles -bool true'
    run 'defaults write NSGlobalDomain AppleShowAllExtensions -bool true'
    run 'defaults write com.apple.finder ShowPathbar -bool true'
    run 'defaults write com.apple.finder ShowStatusBar -bool true'
    run 'defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"'
    run 'defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"'
    run 'defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true'
    run 'defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true'
}

cat_dock() {
    section "Dock"
    run 'defaults write com.apple.dock autohide -bool true'
    run 'defaults write com.apple.dock autohide-delay -float 0'
    run 'defaults write com.apple.dock autohide-time-modifier -float 0.3'
    run 'defaults write com.apple.dock tilesize -int 48'
    run 'defaults write com.apple.dock show-recents -bool false'
    run 'defaults write com.apple.dock mineffect -string "scale"'
}

cat_keyboard() {
    section "Keyboard"
    run 'defaults write NSGlobalDomain KeyRepeat -int 2'
    run 'defaults write NSGlobalDomain InitialKeyRepeat -int 15'
    run 'defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false'
    run 'defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false'
    run 'defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false'
    run 'defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false'
    run 'defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false'
}

cat_trackpad() {
    section "Trackpad"
    run 'defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true'
}

cat_screenshot() {
    section "Screenshot"
    run 'mkdir -p "$HOME/Pictures/Screenshots"'
    run 'defaults write com.apple.screencapture location "$HOME/Pictures/Screenshots"'
    run 'defaults write com.apple.screencapture type -string "png"'
    run 'defaults write com.apple.screencapture disable-shadow -bool true'
}

cat_safari() {
    section "Safari (Developer)"
    run 'defaults write com.apple.Safari IncludeDevelopMenu -bool true'
    run 'defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true'
}

cat_performance() {
    section "Performance"
    run 'defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false'
}

cat_developer() {
    section "Developer"
    run 'defaults write com.apple.dt.Xcode ShowBuildOperationDuration -bool true'
    run 'defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true'
    run 'chflags nohidden "$HOME/Library"'
}

run_category() {
    case "$1" in
        finder)      cat_finder ;;
        dock)        cat_dock ;;
        keyboard)    cat_keyboard ;;
        trackpad)    cat_trackpad ;;
        screenshot)  cat_screenshot ;;
        safari)      cat_safari ;;
        performance) cat_performance ;;
        developer)   cat_developer ;;
        *)
            echo "Unknown category: $1"
            echo "Available: ${CATEGORIES[*]}"
            exit 1
            ;;
    esac
}

# === Main ===

echo "=============================================="
echo "  macOS Starter - System Defaults"
echo "=============================================="
$DRY_RUN && echo "🔍 DRY-RUN: 不会真实写入 defaults，仅打印命令"

# 关闭系统偏好，避免冲突
$DRY_RUN || osascript -e 'tell application "System Preferences" to quit' 2>/dev/null || true

# 确认
if $RUN_ALL && ! $NO_CONFIRM && ! $DRY_RUN; then
    echo
    echo "将应用以下分类：${CATEGORIES[*]}"
    read -p "继续？[y/N] " -n 1 -r REPLY
    echo
    [[ "$REPLY" =~ ^[Yy]$ ]] || { echo "已取消"; exit 0; }
fi

if $RUN_ALL; then
    for c in "${CATEGORIES[@]}"; do
        run_category "$c"
    done
else
    run_category "$SELECTED"
fi

# 重启服务（dry-run 跳过）
if ! $DRY_RUN; then
    section "Restarting services"
    killall Finder        2>/dev/null || true
    killall Dock          2>/dev/null || true
    killall SystemUIServer 2>/dev/null || true
fi

echo
echo "=============================================="
$DRY_RUN && echo "✅ DRY-RUN done."
$DRY_RUN || echo "✅ Done. 部分变更需重启或注销后生效。"
echo "=============================================="
