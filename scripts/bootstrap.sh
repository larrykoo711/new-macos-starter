#!/bin/bash
#
# macOS Starter - Bootstrap Script
# One-click installation of development environment
#
# Usage: ./bootstrap.sh [--with-macos-defaults]
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

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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

# Install packages from Brewfile
install_brew_packages() {
    if [[ -f "$SCRIPT_DIR/Brewfile" ]]; then
        log_info "Installing packages from Brewfile..."
        brew bundle install --file="$SCRIPT_DIR/Brewfile"
        log_success "Brew packages installed"
    else
        log_error "Brewfile not found at $SCRIPT_DIR/Brewfile"
        exit 1
    fi
}

# Setup Oh-My-Zsh (optional, for users who want it)
setup_ohmyzsh() {
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        log_info "Installing Oh-My-Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

        # Install plugins
        ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

        if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
            git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
        fi

        if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
            git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
        fi

        log_success "Oh-My-Zsh installed with plugins"
    else
        log_success "Oh-My-Zsh already installed"
    fi
}

# Apply macOS defaults
apply_macos_defaults() {
    if [[ -f "$SCRIPT_DIR/macos-defaults.sh" ]]; then
        log_info "Applying macOS defaults..."
        bash "$SCRIPT_DIR/macos-defaults.sh"
        log_success "macOS defaults applied"
    fi
}

# Cleanup
cleanup() {
    log_info "Cleaning up..."
    brew cleanup
    log_success "Cleanup complete"
}

# Print summary
print_summary() {
    echo ""
    echo "================================================"
    echo "              Setup Complete!"
    echo "================================================"
    echo ""
    echo "Installed:"
    echo "  - Homebrew + all packages from Brewfile"
    echo "  - Programming fonts"
    echo "  - Oh-My-Zsh with plugins"
    echo ""
    echo "Next steps:"
    echo "  1. Restart terminal: source ~/.zshrc"
    echo "  2. Setup Node.js:    fnm install --lts && fnm default lts-latest"
    echo "  3. Setup Python:     uv python install 3.12"
    echo "  4. Configure Git:    See docs/05-dev-environment.md"
    echo ""
    echo "See docs/ for detailed configuration guides."
    echo ""
}

# Main
main() {
    print_header

    check_macos
    check_arch
    install_xcode_cli
    install_rosetta
    install_homebrew
    install_brew_packages
    setup_ohmyzsh

    # Apply macOS defaults if requested
    if [[ "$1" == "--with-macos-defaults" ]]; then
        apply_macos_defaults
    fi

    cleanup
    print_summary
}

main "$@"
