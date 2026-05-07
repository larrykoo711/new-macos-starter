# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

macOS Starter is an opinionated macOS development environment setup guide. It provides:
- Interactive AI-powered setup wizard (`/new-macos-setup` command)
- Configuration files for shell, git, editors, and terminal
- Documentation for manual setup reference
- Role-based presets (fullstack, frontend, backend, data, devops)

## Key Commands

```bash
# Bootstrap prerequisites (Xcode CLI, Homebrew)
./scripts/bootstrap.sh

# Verify installation status
./scripts/verify.sh

# Interactive setup (in Claude Code)
/new-macos-setup                      # Full interactive wizard
/new-macos-setup --preset fullstack   # Use preset configuration
/new-macos-setup --dry-run            # Preview without installing
```

## Architecture

```
.claude/
├── commands/new-macos-setup.md       # /new-macos-setup command definition
└── skills/macos-setup/     # AI setup wizard skill
    ├── SKILL.md            # Skill logic and Q&A flow
    ├── presets.md          # Role-based configurations
    └── packages.md         # Package registry

configs/                    # Template configurations
├── shell/.zshrc            # Zsh configuration (Oh-My-Zsh + Starship)
├── git/.gitconfig          # Git aliases and delta setup
├── editors/vscode-settings.json
└── terminal/starship.toml

scripts/
├── bootstrap.sh            # Prerequisites installer
├── verify.sh               # Installation verification (+ --json in v0.2)
├── install-dotfiles.sh     # Symlink configs/ → ~ (v0.2 NEW)
├── macos-defaults.sh       # macOS system tweaks (v0.2)
└── Brewfile                # Homebrew package definitions
```

## /new-macos-setup Skill Execution Flow

1. **Network Check** - Verify GitHub/Homebrew access, configure proxy if needed
2. **System Detection** - Version-aware detection: `tool --version` + `brew list --versions`
3. **Interactive Q&A** - Use `AskUserQuestion` to collect preferences
4. **Plan Generation** - Create markdown plan with skip detection
5. **Execution** - Run `brew install` commands with progress tracking via `TodoWrite`
6. **macOS Defaults** - Run `scripts/macos-defaults.sh` (category-based with `--dry-run`)
7. **Config Deployment** (v0.2) - Run `scripts/install-dotfiles.sh` to symlink `configs/` → `~`
8. **Verification** - Run `scripts/verify.sh` (use `--json` for machine-readable output)

### Phase 9: Config Deployment (v0.2)

After packages installed, deploy dotfiles via symlink:

```bash
./scripts/install-dotfiles.sh --dry-run    # preview backup + symlink plan
./scripts/install-dotfiles.sh              # apply (auto-backup .bak.<timestamp>)
```

`~/.gitconfig` requires `user.name` / `user.email` confirmation via AskUserQuestion before symlinking.
`configs/claude/settings.json` is NOT auto-symlinked (Claude Code has its own settings hierarchy);
prompt user to manually `cp configs/claude/settings.json ~/.claude/settings.json`.

## Configuration Targets

When applying configurations, copy to user home directory:
- `configs/shell/.zshrc` → `~/.zshrc`
- `configs/shell/.zprofile` → `~/.zprofile`
- `configs/git/.gitconfig` → `~/.gitconfig`
- `configs/git/.gitignore_global` → `~/.gitignore_global`
- `configs/terminal/starship.toml` → `~/.config/starship.toml`

## Package Managers

| Language | Manager | Install Command |
|----------|---------|-----------------|
| Node.js | fnm | `fnm install --lts && fnm default lts-latest` |
| Python | uv | `uv python install 3.12` |
| Go | goenv | `goenv install <version> && goenv global <version>` |

## Tool Detection Patterns

```bash
# CLI tools
command -v <tool> &>/dev/null

# Applications
[ -d "/Applications/<App>.app" ]

# Oh-My-Zsh
[ -d "$HOME/.oh-my-zsh" ]
```

## Important Notes

- Always detect before installing - skip already installed tools
- Network connectivity check is required before Homebrew operations
- Proxy configuration may be needed for China users (default: `http://127.0.0.1:7890`)
- Use `brew install --cask` for GUI applications
- Starship replaces bullet-train theme (set `ZSH_THEME=""`)
