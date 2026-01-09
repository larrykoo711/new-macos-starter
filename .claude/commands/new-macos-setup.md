---
description: Interactive macOS development environment setup wizard - detects existing tools, asks preferences, generates and executes installation plan
allowed-tools: Bash(*), Read(**), Write(**), AskUserQuestion
argument-hint: [--quick] [--preset <preset>] [--dry-run]
# examples:
#   - /new-macos-setup                    # Full interactive setup
#   - /new-macos-setup --quick            # Quick setup with sensible defaults
#   - /new-macos-setup --preset fullstack # Use fullstack developer preset
#   - /new-macos-setup --dry-run          # Generate plan without executing
---

# macOS Starter - Interactive Setup Wizard

> From Zero to Hero - AI-powered macOS development environment configuration

## Overview

This command provides an **interactive, conversational setup experience** for configuring a new macOS development environment. It:

1. **Detects** what's already installed on your system
2. **Asks** your preferences through guided questions
3. **Generates** a customized installation plan
4. **Executes** the plan step-by-step with progress tracking

## Usage

```bash
/new-macos-setup                      # Full interactive mode
/new-macos-setup --quick              # Quick setup with defaults
/new-macos-setup --preset fullstack   # Use a preset configuration
/new-macos-setup --dry-run            # Preview plan without installing
```

### Options

- `--quick`: Skip detailed questions, use sensible defaults
- `--preset <name>`: Use a predefined configuration (fullstack, frontend, backend, data, devops)
- `--dry-run`: Generate and display the plan without executing

---

## Execution Flow

### Phase 0: Network Connectivity Check (REQUIRED)

**Before any installation, verify network access to GitHub and Google:**

```bash
# Test network connectivity
echo "=== Network Connectivity Check ==="

echo "Testing GitHub..."
curl -s --connect-timeout 5 https://github.com > /dev/null 2>&1 && echo "✅ GitHub: accessible" || echo "❌ GitHub: not accessible"

echo "Testing Google..."
curl -s --connect-timeout 5 https://www.google.com > /dev/null 2>&1 && echo "✅ Google: accessible" || echo "❌ Google: not accessible"

echo "Testing Homebrew sources..."
curl -s --connect-timeout 5 https://raw.githubusercontent.com > /dev/null 2>&1 && echo "✅ Homebrew: accessible" || echo "❌ Homebrew: not accessible"
```

**If network issues detected, ask user for proxy configuration:**

```
Do you need to configure a network proxy?
- Yes, I have a proxy (e.g., http://127.0.0.1:7890)
- No, let me fix my network first
```

**If proxy needed, collect and set:**

```bash
# User provides proxy URL, then set environment variables:
export http_proxy="http://127.0.0.1:7890"
export https_proxy="http://127.0.0.1:7890"
export HTTP_PROXY="http://127.0.0.1:7890"
export HTTPS_PROXY="http://127.0.0.1:7890"
export ALL_PROXY="http://127.0.0.1:7890"

# For Git
git config --global http.proxy "http://127.0.0.1:7890"
git config --global https.proxy "http://127.0.0.1:7890"

# Re-test connectivity
curl -s --connect-timeout 5 https://github.com > /dev/null 2>&1 && echo "✅ Proxy working"
```

**IMPORTANT:** Do not proceed until network connectivity is verified.

---

### Phase 1: System Detection

Automatically detect installed software:

```bash
# Check core tools
command -v brew && echo "Homebrew: installed"
command -v git && echo "Git: installed"
command -v zsh && echo "Zsh: installed"
[ -d "$HOME/.oh-my-zsh" ] && echo "Oh-My-Zsh: installed"
command -v code && echo "VS Code: installed"
command -v cursor && echo "Cursor: installed"

# Check language managers
command -v fnm && echo "fnm: installed"
command -v node && echo "Node.js: installed"
command -v uv && echo "uv: installed"
command -v python3 && echo "Python: installed"
command -v go && echo "Go: installed"
command -v goenv && echo "goenv: installed"

# Check applications
[ -d "/Applications/Raycast.app" ] && echo "Raycast: installed"
[ -d "/Applications/Warp.app" ] && echo "Warp: installed"
[ -d "/Applications/OrbStack.app" ] && echo "OrbStack: installed"
```

Output a summary table of detected vs missing tools.

### Phase 2: Interactive Questions (unless --quick or --preset)

Use `AskUserQuestion` tool to gather preferences. Questions should be asked in sequence:

#### Q1: Developer Role
```
What best describes your primary development role?
- Fullstack Developer (React/Vue + Node.js + Database)
- Frontend Developer (React/Vue/Svelte + UI/Design)
- Backend Developer (Go/Python/Java + APIs + Infrastructure)
- Data/ML Engineer (Python + Jupyter + ML frameworks)
- DevOps/Platform Engineer (K8s + Terraform + CI/CD)
```

#### Q2: Programming Languages
```
Which programming languages do you need? (select all that apply)
- JavaScript/TypeScript (fnm + pnpm)
- Python (uv)
- Go (goenv)
- Rust (rustup)
- Java (SDKMAN)
```

#### Q3: Container & Kubernetes
```
Do you need container and Kubernetes tools?
- Yes, full setup (OrbStack + kubectl + helm + k9s)
- Basic only (OrbStack for Docker)
- No, skip containers
```

#### Q4: Cloud Platforms
```
Which cloud CLI tools do you need?
- AWS CLI
- Google Cloud SDK
- Azure CLI
- None
```

#### Q5: Collaboration Apps
```
Which collaboration apps should be installed?
- Work Suite (Lark/DingTalk/WeCom + Tencent Meeting)
- International (Slack + Discord + WhatsApp)
- Both
- None
```

#### Q6: macOS Optimization
```
Which macOS optimizations do you want?
- Dock: Hide recent apps, faster animations
- Keyboard: Faster key repeat, disable auto-correct
- Finder: Show hidden files, path bar
- Screenshots: Change save location
- All of the above
- None
```

### Phase 3: Generate Installation Plan

Based on detection and preferences, generate a structured plan:

```markdown
## Installation Plan

### Already Installed (Skip)
- [x] Homebrew
- [x] Git
- [x] VS Code

### Phase 1: CLI Tools
- [ ] delta (git diff enhancer)
- [ ] starship (modern prompt)
- [ ] eza, bat, fd, ripgrep (modern CLI)

### Phase 2: Language Environment
- [ ] fnm + Node.js LTS + pnpm
- [ ] uv + Python 3.12
- [ ] goenv + Go latest

### Phase 3: Development Apps
- [ ] Cursor
- [ ] Warp
- [ ] OrbStack

### Phase 4: System Enhancement
- [ ] Raycast
- [ ] KeepingYouAwake
- [ ] Fonts (JetBrains Mono Nerd Font)

### Phase 5: macOS Optimization
- [ ] Dock settings
- [ ] Keyboard settings

Estimated time: ~15 minutes
```

### Phase 4: Execute Plan

Execute each phase with clear progress:

1. Show current step being executed
2. Run the installation command
3. Verify success
4. Mark as complete
5. Move to next step

Use TodoWrite to track progress visible to user.

### Phase 5: Post-Setup Verification

```bash
# Verify all tools
echo "=== Verification ==="
eza --version
bat --version
starship --version
fnm --version
node --version
pnpm --version
# ... etc
```

---

## Presets Reference

Load from `.claude/skills/macos-setup/presets.md`:

| Preset | Description |
|--------|-------------|
| `fullstack` | JS/TS + Python + Docker + All apps |
| `frontend` | JS/TS + Design tools + Basic apps |
| `backend` | Go/Python + Docker + K8s + AWS |
| `data` | Python + Jupyter + ML tools |
| `devops` | Docker + K8s + Terraform + Cloud CLIs |

---

## Safety Rules

1. **Never remove** existing software unless explicitly requested
2. **Always verify** before executing destructive operations
3. **Skip** already installed packages automatically
4. **Show** dry-run output before actual installation
5. **Allow** user to cancel at any phase

---

## Output Format

Always provide clear, structured output:

```
🔍 Detecting installed software...
✅ Homebrew: installed (v4.2.0)
✅ Git: installed (v2.43.0)
❌ Starship: not installed

📋 Installation Plan Generated
━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Phase 1: CLI Tools (5 packages)
Phase 2: Languages (3 environments)
Phase 3: Apps (8 applications)
Phase 4: System (3 optimizations)

⏱️  Estimated time: 15 minutes

Ready to proceed? [Y/n]
```

---

## Related Files

- `.claude/skills/macos-setup/SKILL.md` - Skill definition
- `.claude/skills/macos-setup/presets.md` - Preset configurations
- `.claude/skills/macos-setup/packages.md` - Package registry
- `configs/` - Configuration templates (shell, git, editors, terminal)
- `docs/` - Detailed documentation for manual reference
