#!/bin/bash
#
# macOS Starter - Installation Verification Script
# Verifies that all tools are properly installed
#
# Usage: ./scripts/verify.sh
#

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

success() { echo -e "${GREEN}✅${NC} $1"; }
fail() { echo -e "${RED}❌${NC} $1"; }
warn() { echo -e "${YELLOW}⚠️${NC} $1"; }

# Check command exists and show version
check_cmd() {
    local cmd=$1
    local name=${2:-$1}
    if command -v "$cmd" &>/dev/null; then
        local version
        version=$("$cmd" --version 2>/dev/null | head -1 || echo "installed")
        success "$name: $version"
        return 0
    else
        fail "$name: not found"
        return 1
    fi
}

# Check app exists
check_app() {
    local app=$1
    if [ -d "/Applications/$app.app" ]; then
        success "$app"
        return 0
    else
        fail "$app"
        return 1
    fi
}

# Main
echo ""
echo "================================================"
echo "   macOS Starter - Installation Verification"
echo "================================================"
echo ""

TOTAL=0
PASSED=0

# Core Tools
echo "--- Core Tools ---"
check_cmd brew "Homebrew" && ((PASSED++)); ((TOTAL++))
check_cmd git "Git" && ((PASSED++)); ((TOTAL++))
check_cmd gh "GitHub CLI" && ((PASSED++)); ((TOTAL++))
check_cmd delta "Delta" && ((PASSED++)); ((TOTAL++))
check_cmd starship "Starship" && ((PASSED++)); ((TOTAL++))
echo ""

# Modern CLI
echo "--- Modern CLI ---"
check_cmd eza "eza (ls)" && ((PASSED++)); ((TOTAL++))
check_cmd bat "bat (cat)" && ((PASSED++)); ((TOTAL++))
check_cmd fd "fd (find)" && ((PASSED++)); ((TOTAL++))
check_cmd rg "ripgrep (grep)" && ((PASSED++)); ((TOTAL++))
echo ""

# Languages
echo "--- Languages ---"
check_cmd fnm "fnm" && ((PASSED++)); ((TOTAL++))
check_cmd node "Node.js" && ((PASSED++)); ((TOTAL++))
check_cmd pnpm "pnpm" && ((PASSED++)); ((TOTAL++))
check_cmd uv "uv" && ((PASSED++)); ((TOTAL++))
check_cmd python3 "Python" && ((PASSED++)); ((TOTAL++))
check_cmd go "Go" && ((PASSED++)); ((TOTAL++))
echo ""

# Container
echo "--- Container & K8s ---"
check_cmd docker "Docker" && ((PASSED++)); ((TOTAL++))
check_cmd kubectl "kubectl" && ((PASSED++)); ((TOTAL++))
check_cmd helm "Helm" && ((PASSED++)); ((TOTAL++))
check_cmd k9s "k9s" && ((PASSED++)); ((TOTAL++))
echo ""

# Applications
echo "--- Applications ---"
check_app "Raycast" && ((PASSED++)); ((TOTAL++))
check_app "Warp" && ((PASSED++)); ((TOTAL++))
check_app "Cursor" && ((PASSED++)); ((TOTAL++))
check_app "Visual Studio Code" && ((PASSED++)); ((TOTAL++))
check_app "OrbStack" && ((PASSED++)); ((TOTAL++))
echo ""

# Vibe Coding Tools
echo "--- Vibe Coding ---"
check_cmd claude "Claude Code" && ((PASSED++)); ((TOTAL++))
check_app "LM Studio" && ((PASSED++)); ((TOTAL++))
echo ""

# Shell Configuration
echo "--- Shell Config ---"
if [ -d "$HOME/.oh-my-zsh" ]; then
    success "Oh-My-Zsh"
    ((PASSED++))
else
    fail "Oh-My-Zsh"
fi
((TOTAL++))

if [ -f "$HOME/.config/starship.toml" ]; then
    success "Starship config"
    ((PASSED++))
else
    warn "Starship config (using defaults)"
fi
((TOTAL++))
echo ""

# Summary
echo "================================================"
PERCENT=$((PASSED * 100 / TOTAL))
if [ $PERCENT -ge 80 ]; then
    echo -e "${GREEN}Result: $PASSED/$TOTAL ($PERCENT%)${NC}"
elif [ $PERCENT -ge 50 ]; then
    echo -e "${YELLOW}Result: $PASSED/$TOTAL ($PERCENT%)${NC}"
else
    echo -e "${RED}Result: $PASSED/$TOTAL ($PERCENT%)${NC}"
fi
echo "================================================"
echo ""

if [ $PERCENT -ge 80 ]; then
    echo "Your macOS development environment is ready!"
else
    echo "Some tools are missing. Run '/setup' to install them."
fi
echo ""
