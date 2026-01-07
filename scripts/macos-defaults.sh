#!/bin/bash
#
# macOS System Defaults Configuration Script
#
set -e

echo "Configuring macOS defaults..."

# Close System Preferences/Settings to prevent conflicts
# macOS 13+ uses "System Settings", older versions use "System Preferences"
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null || true

# =======================
# Finder
# =======================
echo "Configuring Finder..."

# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Search current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Use list view by default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Disable .DS_Store on network drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# =======================
# Dock
# =======================
echo "Configuring Dock..."

# Auto-hide Dock
defaults write com.apple.dock autohide -bool true

# Remove auto-hide delay
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0.3

# Set icon size
defaults write com.apple.dock tilesize -int 48

# Disable recent apps
defaults write com.apple.dock show-recents -bool false

# Use scale effect for minimizing
defaults write com.apple.dock mineffect -string "scale"

# =======================
# Keyboard
# =======================
echo "Configuring Keyboard..."

# Fast key repeat
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Disable auto-capitalize
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart quotes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable press-and-hold for keys
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# =======================
# Trackpad
# =======================
echo "Configuring Trackpad..."

# Enable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# =======================
# Screenshots
# =======================
echo "Configuring Screenshots..."

# Create screenshots directory
mkdir -p "$HOME/Pictures/Screenshots"

# Save screenshots to ~/Pictures/Screenshots
defaults write com.apple.screencapture location "$HOME/Pictures/Screenshots"

# Save as PNG
defaults write com.apple.screencapture type -string "png"

# Disable shadow
defaults write com.apple.screencapture disable-shadow -bool true

# =======================
# Safari (Developer)
# =======================
echo "Configuring Safari..."

# Show Develop menu
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# =======================
# Performance
# =======================
echo "Configuring Performance..."

# Disable window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Speed up window resize
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# =======================
# Security
# =======================
echo "Configuring Security..."

# Enable firewall
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on 2>/dev/null || true

# =======================
# Misc
# =======================
echo "Configuring Misc..."

# Disable Time Machine new disk prompts
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Show Library folder
chflags nohidden ~/Library 2>/dev/null || true

# =======================
# Restart affected services
# =======================
echo "Restarting services..."

killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true
killall SystemUIServer 2>/dev/null || true

echo ""
echo "macOS defaults configuration complete!"
echo ""
echo "Note: Some changes require logout/restart to take effect."
