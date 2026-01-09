#!/bin/bash
#
# macOS Starter - Bootstrap Script
# Minimal setup: Xcode CLI + Homebrew + AI Tools
#
# Usage: ./bootstrap.sh
#
set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# Header
print_header() {
    echo ""
    echo "================================================"
    echo "       macOS Starter - Bootstrap Script"
    echo "================================================"
    echo ""
}

# Check macOS
check_macos() {
    if [[ "$(uname)" != "Darwin" ]]; then
        log_error "This script is for macOS only!"
        exit 1
    fi
    log_success "macOS $(sw_vers -productVersion)"
}

# Check network connectivity
check_network() {
    log_info "Checking network connectivity..."

    local github_ok=false
    local homebrew_ok=false

    if curl -s --connect-timeout 5 https://github.com > /dev/null 2>&1; then
        github_ok=true
        log_success "GitHub: accessible"
    else
        log_warning "GitHub: not accessible"
    fi

    if curl -s --connect-timeout 5 https://raw.githubusercontent.com > /dev/null 2>&1; then
        homebrew_ok=true
        log_success "Homebrew sources: accessible"
    else
        log_warning "Homebrew sources: not accessible"
    fi

    if [[ "$github_ok" == false ]] || [[ "$homebrew_ok" == false ]]; then
        echo ""
        log_warning "Network issues detected. You may need to configure a proxy."
        echo ""
        echo "  To set proxy for this session:"
        echo "    export http_proxy=\"http://127.0.0.1:7890\""
        echo "    export https_proxy=\"http://127.0.0.1:7890\""
        echo ""
        read -p "Continue anyway? [y/N] " -n 1 -r
        echo ""
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log_info "Please configure your network and try again."
            exit 0
        fi
    fi
}

# Check architecture and set Homebrew prefix
check_arch() {
    if [[ "$(uname -m)" == "arm64" ]]; then
        log_success "Apple Silicon (arm64)"
        HOMEBREW_PREFIX="/opt/homebrew"
    else
        log_success "Intel (x86_64)"
        HOMEBREW_PREFIX="/usr/local"
    fi
}

# Install Xcode Command Line Tools
install_xcode_cli() {
    log_info "Checking Xcode CLI Tools..."
    if ! xcode-select -p &>/dev/null; then
        log_info "Installing Xcode Command Line Tools..."
        xcode-select --install
        log_warning "Please complete installation and re-run this script."
        exit 0
    fi
    log_success "Xcode CLI Tools installed"
}

# Install Rosetta 2 (Apple Silicon only)
install_rosetta() {
    if [[ "$(uname -m)" == "arm64" ]]; then
        if ! /usr/bin/pgrep -q oahd; then
            log_info "Installing Rosetta 2..."
            softwareupdate --install-rosetta --agree-to-license
            log_success "Rosetta 2 installed"
        else
            log_success "Rosetta 2 already installed"
        fi
    fi
}

# Install Homebrew
install_homebrew() {
    log_info "Checking Homebrew..."
    if ! command -v brew &>/dev/null; then
        log_info "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

        # Add to .zprofile if not already present
        if ! grep -q "brew shellenv" ~/.zprofile 2>/dev/null; then
            echo 'eval "$('$HOMEBREW_PREFIX'/bin/brew shellenv)"' >> ~/.zprofile
        fi
        eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"

        log_success "Homebrew installed"
    else
        log_success "Homebrew already installed"
        brew update
    fi
}

# Print next steps
print_summary() {
    echo ""
    echo "================================================"
    echo "         Prerequisites Complete!"
    echo "================================================"
    echo ""
    echo "Installed:"
    echo "  - Xcode Command Line Tools"
    echo "  - Rosetta 2 (Apple Silicon)"
    echo "  - Homebrew"
    echo ""
    echo "=============================================="
    echo "  NEXT: AI-Powered Interactive Setup"
    echo "=============================================="
    echo ""
    echo "Option 1: Claude Code (Recommended)"
    echo "  brew install --cask claude-code"
    echo "  cd $(pwd)"
    echo "  claude"
    echo "  # Then type: /setup"
    echo ""
    echo "Option 2: Cursor"
    echo "  brew install --cask cursor"
    echo "  # Open this folder in Cursor"
    echo "  # In terminal, type: /setup"
    echo ""
    echo "The AI wizard will:"
    echo "  1. Detect what's already installed"
    echo "  2. Ask your preferences (role, languages, apps)"
    echo "  3. Generate a customized plan"
    echo "  4. Execute step-by-step with progress tracking"
    echo ""
}

# Main
main() {
    print_header
    check_macos
    check_arch
    check_network
    install_xcode_cli
    install_rosetta
    install_homebrew
    print_summary
}

main "$@"
