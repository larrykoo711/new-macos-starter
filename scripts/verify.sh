#!/bin/bash
#
# macOS Starter - Installation Verification Script
# Verifies that all tools are properly installed
#
# Usage:
#   ./scripts/verify.sh           # human-readable output
#   ./scripts/verify.sh --json    # machine-readable JSON (for /health-check)
#

# Parse flag
JSON_MODE=false
[[ "${1:-}" == "--json" ]] && JSON_MODE=true

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Quiet helpers when in JSON mode
success() { $JSON_MODE || echo -e "${GREEN}✅${NC} $1"; }
fail()    { $JSON_MODE || echo -e "${RED}❌${NC} $1"; }
warn()    { $JSON_MODE || echo -e "${YELLOW}⚠️${NC} $1"; }

# JSON results buffer (one line per item)
RESULTS=()

# Append a JSON record
record() {
    local name="$1" cmd="$2" status="$3" version="$4"
    # 转义双引号
    name="${name//\"/\\\"}"
    version="${version//\"/\\\"}"
    if [[ -z "$version" ]]; then
        RESULTS+=("{\"name\":\"$name\",\"cmd\":\"$cmd\",\"status\":\"$status\",\"version\":null}")
    else
        RESULTS+=("{\"name\":\"$name\",\"cmd\":\"$cmd\",\"status\":\"$status\",\"version\":\"$version\"}")
    fi
}

# Check command exists and show version
check_cmd() {
    local cmd=$1
    local name=${2:-$1}
    if command -v "$cmd" &>/dev/null; then
        local version
        version=$("$cmd" --version 2>/dev/null | head -1 || echo "installed")
        success "$name: $version"
        record "$name" "$cmd" "ok" "$version"
        return 0
    else
        fail "$name: not found"
        record "$name" "$cmd" "missing" ""
        return 1
    fi
}

# Check app exists
check_app() {
    local app=$1
    if [ -d "/Applications/$app.app" ]; then
        success "$app"
        record "$app" "/Applications/$app.app" "ok" "installed"
        return 0
    else
        fail "$app"
        record "$app" "/Applications/$app.app" "missing" ""
        return 1
    fi
}

# Check that path exists (file or dir or symlink)
check_path() {
    local path="$1" name="$2"
    if [ -e "$path" ] || [ -L "$path" ]; then
        success "$name"
        record "$name" "$path" "ok" ""
        return 0
    else
        warn "$name (not found)"
        record "$name" "$path" "missing" ""
        return 1
    fi
}

# Main
$JSON_MODE || {
    echo ""
    echo "================================================"
    echo "   macOS Starter - Installation Verification"
    echo "================================================"
    echo ""
}

TOTAL=0
PASSED=0
inc() { ((TOTAL++)); [[ "$1" == "0" ]] && ((PASSED++)); }

run() { "$@"; inc $?; }

# Core Tools
$JSON_MODE || echo "--- Core Tools ---"
run check_cmd brew "Homebrew"
run check_cmd git "Git"
run check_cmd gh "GitHub CLI"
run check_cmd delta "Delta"
run check_cmd starship "Starship"
$JSON_MODE || echo ""

# Modern CLI
$JSON_MODE || echo "--- Modern CLI ---"
run check_cmd eza "eza (ls)"
run check_cmd bat "bat (cat)"
run check_cmd fd "fd (find)"
run check_cmd rg "ripgrep (grep)"
$JSON_MODE || echo ""

# Languages
$JSON_MODE || echo "--- Languages ---"
run check_cmd fnm "fnm"
run check_cmd node "Node.js"
run check_cmd pnpm "pnpm"
run check_cmd uv "uv"
run check_cmd python3 "Python"
run check_cmd go "Go"
$JSON_MODE || echo ""

# Container
$JSON_MODE || echo "--- Container & K8s ---"
run check_cmd docker "Docker"
run check_cmd kubectl "kubectl"
run check_cmd helm "Helm"
run check_cmd k9s "k9s"
$JSON_MODE || echo ""

# Cloud & Security CLI (v0.2)
$JSON_MODE || echo "--- Cloud & Security CLI ---"
run check_cmd op "1Password CLI"
run check_cmd stripe "Stripe CLI"
run check_cmd vercel "Vercel CLI"
run check_cmd gcloud "Google Cloud SDK"
$JSON_MODE || echo ""

# Applications
$JSON_MODE || echo "--- Applications ---"
run check_app "Raycast"
run check_app "Ghostty"
run check_app "Warp"
run check_app "Visual Studio Code"
run check_app "OrbStack"
run check_cmd tmux "tmux"
$JSON_MODE || echo ""

# Vibe Coding Tools
$JSON_MODE || echo "--- Vibe Coding ---"
run check_cmd claude "Claude Code"
run check_app "Cherry Studio"
$JSON_MODE || echo ""

# Shell Configuration
$JSON_MODE || echo "--- Shell Config ---"
if [ -d "$HOME/.oh-my-zsh" ]; then
    success "Oh-My-Zsh"
    record "Oh-My-Zsh" "$HOME/.oh-my-zsh" "ok" ""
    inc 0
else
    fail "Oh-My-Zsh"
    record "Oh-My-Zsh" "$HOME/.oh-my-zsh" "missing" ""
    inc 1
fi

if [ -f "$HOME/.config/starship.toml" ] || [ -L "$HOME/.config/starship.toml" ]; then
    success "Starship config"
    record "Starship config" "$HOME/.config/starship.toml" "ok" ""
    inc 0
else
    warn "Starship config (using defaults)"
    record "Starship config" "$HOME/.config/starship.toml" "missing" ""
    inc 1
fi
$JSON_MODE || echo ""

# Dotfiles deployment (v0.2)
$JSON_MODE || echo "--- Dotfiles ---"
if [ -L "$HOME/.zshrc" ]; then
    success ".zshrc (symlinked)"
    record ".zshrc symlink" "$HOME/.zshrc" "ok" "$(readlink "$HOME/.zshrc")"
    inc 0
else
    warn ".zshrc (not symlinked, run scripts/install-dotfiles.sh)"
    record ".zshrc symlink" "$HOME/.zshrc" "missing" ""
    inc 1
fi

if [ -n "${KUBECONFIG:-}" ]; then
    success "KUBECONFIG (set: ${KUBECONFIG//:/, })"
    record "KUBECONFIG" "env" "ok" "${KUBECONFIG}"
    inc 0
else
    warn "KUBECONFIG (not set)"
    record "KUBECONFIG" "env" "missing" ""
    inc 1
fi
$JSON_MODE || echo ""

# Summary
PERCENT=$((PASSED * 100 / TOTAL))

if $JSON_MODE; then
    # JSON output
    TIMESTAMP=$(date -u +%Y-%m-%dT%H:%M:%SZ)
    MACOS_VER=$(sw_vers -productVersion 2>/dev/null || echo "unknown")
    # 拼接 results 数组
    OLDIFS=$IFS
    IFS=','
    RESULTS_JSON="${RESULTS[*]}"
    IFS=$OLDIFS
    cat <<EOF
{
  "timestamp": "$TIMESTAMP",
  "macos_version": "$MACOS_VER",
  "score": {"passed": $PASSED, "total": $TOTAL, "percent": $PERCENT},
  "results": [$RESULTS_JSON]
}
EOF
    exit 0
fi

# Human-readable summary
echo "================================================"
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
    echo "Some tools are missing. Run '/new-macos-setup' to install them,"
    echo "or '/health-check' to get AI-generated fix commands."
fi
echo ""
