#!/bin/bash
#
# macOS Starter - Dotfiles Installer
# 把 configs/ 下的模板 symlink 到 ~ 对应位置；已存在文件自动备份为 .bak.<时间戳>
#
# Usage:
#   ./scripts/install-dotfiles.sh              # 默认模式：备份 + symlink
#   ./scripts/install-dotfiles.sh --dry-run    # 仅预览，不写入
#   ./scripts/install-dotfiles.sh --force      # 直接覆盖（不备份，慎用）
#

set -euo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

success() { echo -e "${GREEN}✅${NC} $1"; }
info()    { echo -e "${BLUE}ℹ️${NC}  $1"; }
warn()    { echo -e "${YELLOW}⚠️${NC} $1"; }
fail()    { echo -e "${RED}❌${NC} $1"; }

# 解析参数
DRY_RUN=false
FORCE=false
for arg in "$@"; do
    case "$arg" in
        --dry-run) DRY_RUN=true ;;
        --force)   FORCE=true ;;
        -h|--help)
            head -10 "$0" | tail -8
            exit 0
            ;;
        *)
            fail "Unknown flag: $arg"
            exit 1
            ;;
    esac
done

# 定位仓库根目录（脚本所在目录的父级）
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# 映射表：仓库相对路径 -> 目标绝对路径
DOTFILES_MAP=(
    "configs/shell/.zshrc:$HOME/.zshrc"
    "configs/shell/.zprofile:$HOME/.zprofile"
    "configs/git/.gitconfig:$HOME/.gitconfig"
    "configs/git/.gitignore_global:$HOME/.gitignore_global"
    "configs/git/commit-template.txt:$HOME/.stCommitMsg"
    "configs/terminal/starship.toml:$HOME/.config/starship.toml"
    "configs/npm/.npmrc:$HOME/.npmrc"
)

TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
LINKED=0; BACKED=0; SKIPPED=0; MISSING=0

echo "=============================================="
echo "  macOS Starter - Dotfiles Installer"
echo "=============================================="
info "Repo root: $REPO_ROOT"
[[ "$DRY_RUN" == "true" ]] && warn "DRY-RUN mode: 不会真实写入文件"
[[ "$FORCE" == "true" ]] && warn "FORCE mode: 不备份，直接覆盖"
echo

for entry in "${DOTFILES_MAP[@]}"; do
    src_rel="${entry%%:*}"
    dst="${entry##*:}"
    src="$REPO_ROOT/$src_rel"

    # 源文件不存在 → 跳过（如 .npmrc 在 Stage 2 之前不存在）
    if [[ ! -f "$src" ]]; then
        warn "skip (source missing): $src_rel"
        ((MISSING++))
        continue
    fi

    # 已是正确 symlink → 跳过（保证幂等）
    if [[ -L "$dst" ]] && [[ "$(readlink "$dst")" == "$src" ]]; then
        info "ok (already linked): $dst"
        ((SKIPPED++))
        continue
    fi

    # 目标已存在但不是正确 symlink → 备份或覆盖
    if [[ -e "$dst" ]] || [[ -L "$dst" ]]; then
        if [[ "$FORCE" == "true" ]]; then
            warn "overwrite: $dst"
            $DRY_RUN || rm -f "$dst"
        else
            bak="${dst}.bak.${TIMESTAMP}"
            warn "backup: $dst → $bak"
            $DRY_RUN || mv "$dst" "$bak"
            ((BACKED++))
        fi
    fi

    # 确保目标目录存在
    dst_dir="$(dirname "$dst")"
    [[ -d "$dst_dir" ]] || { $DRY_RUN || mkdir -p "$dst_dir"; }

    # 创建 symlink
    if $DRY_RUN; then
        info "would link: $dst → $src"
    else
        ln -s "$src" "$dst"
        success "linked: $dst → $src_rel"
    fi
    ((LINKED++))
done

echo
echo "=============================================="
echo "  Summary"
echo "=============================================="
echo "  Linked:   $LINKED"
echo "  Backed:   $BACKED"
echo "  Skipped:  $SKIPPED (already correct)"
echo "  Missing:  $MISSING (source not found)"
echo

# Claude Code settings 单独提示（不做 symlink，因 Claude 有自己的 settings 层级）
CLAUDE_TEMPLATE="$REPO_ROOT/configs/claude/settings.json"
CLAUDE_TARGET="$HOME/.claude/settings.json"
if [[ -f "$CLAUDE_TEMPLATE" ]]; then
    if [[ -f "$CLAUDE_TARGET" ]]; then
        info "Claude settings exists at $CLAUDE_TARGET (skipped)"
    else
        warn "Claude Code settings 模板存在但未自动部署。"
        echo "    手动复制：cp \"$CLAUDE_TEMPLATE\" \"$CLAUDE_TARGET\""
    fi
fi

[[ "$DRY_RUN" == "true" ]] && warn "DRY-RUN done. 执行实际安装：$(basename "$0") (不带 --dry-run)"
success "Done."
