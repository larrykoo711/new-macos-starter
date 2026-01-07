# macOS Starter

> **From Zero to Hero** — An opinionated macOS development environment setup guide for engineers.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-macOS-blue.svg)](https://www.apple.com/macos)
[![Architecture](https://img.shields.io/badge/Architecture-Apple%20Silicon%20%7C%20Intel-green.svg)](https://www.apple.com/mac)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)

**[中文文档](README.zh-CN.md)**

## Philosophy

```
Ship Fast. Break Things. Fix Faster.
```

- **Minimal Friction** — One-click setup, zero resistance to start coding
- **Battle-Tested** — Production-proven toolchain used by top engineers
- **Opinionated** — Curated choices so you don't waste time deciding
- **Reproducible** — Consistent environment across all your machines

## Quick Start

```bash
# Clone this repo
git clone https://github.com/larrykoo711/new-macos-starter.git
cd new-macos-starter

# Run the bootstrap script
./scripts/bootstrap.sh
```

That's it! The script will install Homebrew, CLI tools, applications, fonts, and Oh-My-Zsh with plugins.

### Options

```bash
# Standard installation (recommended)
./scripts/bootstrap.sh

# Include macOS system preferences optimization
./scripts/bootstrap.sh --with-macos-defaults
```

## What's Inside

### Core Stack

| Category | Tool | Why |
|----------|------|-----|
| **Package Manager** | [Homebrew](https://brew.sh) | The standard package manager for macOS |
| **Shell** | Zsh + Oh-My-Zsh + Starship | Modern shell experience with beautiful prompts |
| **Terminal** | [Warp](https://warp.dev) | AI-powered modern terminal |
| **Launcher** | [Raycast](https://raycast.com) | Spotlight replacement + window management |
| **Version Control** | Git + gh CLI | Native GitHub integration |

### Development Environment

| Category | Tool | Why |
|----------|------|-----|
| **Node.js** | fnm + pnpm | Fast version management + efficient package manager |
| **Python** | uv | Rust-built, manages both versions and dependencies |
| **Go** | goenv | Multi-version management |
| **Container** | OrbStack | Lightweight Docker/K8s (replaces Docker Desktop) |
| **Kubernetes** | kubectl + helm + k9s + kubeswitch | Complete cloud-native toolkit |

### Editor & IDE

| Tool | Description |
|------|-------------|
| [Cursor](https://cursor.sh) | AI-first code editor (primary) |
| [VS Code](https://code.visualstudio.com) | Backup editor |
| [JetBrains Toolbox](https://www.jetbrains.com/toolbox-app/) | JetBrains IDE manager |

### Vibe Coding (AI-Assisted Programming)

| Tool | Description |
|------|-------------|
| [Claude Code](https://claude.ai/claude-code) | Anthropic's official CLI for AI programming in terminal |
| [Cursor](https://cursor.sh) | AI-first code editor |
| [OpenCode](https://github.com/opencode-ai/opencode) | Open-source terminal AI coding tool |

### Essential Apps

| Category | Apps |
|----------|------|
| **Must Have** | Raycast, 1Password, Chrome, KeepingYouAwake, Keka |
| **Development** | Cursor, Warp, OrbStack, Apifox, Proxyman, Sourcetree |
| **Productivity** | Notion, Slack, Discord |
| **AI Tools** | Claude Code, LM Studio |
| **System** | iStat Menus, MonitorControl, Gas Mask |

## Documentation

| Chapter | Description |
|---------|-------------|
| [01. System Setup](docs/01-system-setup.md) | Initial system configuration |
| [02. Homebrew](docs/02-homebrew.md) | Package manager installation |
| [03. Shell](docs/03-shell.md) | Zsh + Oh-My-Zsh configuration |
| [04. Fonts](docs/04-fonts.md) | Programming fonts installation |
| [05. Dev Environment](docs/05-dev-environment.md) | Git, Node.js, Python, Go, Container |
| [06. Editor](docs/06-editor.md) | VS Code / Cursor configuration |
| [07. Vibe Coding](docs/07-vibe-coding.md) | AI-assisted programming tools |
| [08. Apps](docs/08-apps.md) | Recommended applications |
| [09. macOS](docs/09-macos.md) | System optimization |

## Project Structure

```
macOS-Starter/
├── scripts/
│   ├── bootstrap.sh          # One-click installation entry point
│   ├── Brewfile              # Homebrew packages (CLI, Apps, Fonts)
│   └── macos-defaults.sh     # macOS system preferences (optional)
├── configs/
│   ├── shell/                # .zshrc, .zprofile
│   ├── git/                  # .gitconfig, .gitignore_global
│   ├── editors/              # VS Code settings, Biome config
│   └── terminal/             # Starship prompt config
└── docs/                     # Step-by-step guides (01-09)
```

## Customization

### Using the Brewfile

Edit `scripts/Brewfile` to add or remove packages:

```ruby
# Add a CLI tool
brew "your-tool"

# Add an application
cask "your-app"

# Add a font
cask "font-your-font"
```

Then run:

```bash
brew bundle install --file=scripts/Brewfile
```

### Post-Installation Setup

After running `bootstrap.sh`, complete these manual configurations:

```bash
# 1. Setup Node.js
fnm install --lts
fnm default lts-latest

# 2. Setup Python
uv python install 3.12

# 3. Configure Git (edit with your info)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

See the [documentation](docs/) for detailed guides.

## Tested Environment

| Component | Version |
|-----------|---------|
| macOS | Sequoia 15.x / Sonoma 14.x |
| Architecture | Apple Silicon (M1/M2/M3/M4) / Intel |
| Homebrew | 4.x |
| Node.js | 22.x LTS |
| Python | 3.12+ |
| Go | 1.23+ |

## Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) and [Code of Conduct](CODE_OF_CONDUCT.md) before submitting a PR.

- Found a bug? [Open an issue](https://github.com/larrykoo711/new-macos-starter/issues/new?template=bug_report.md)
- Have a feature idea? [Start a discussion](https://github.com/larrykoo711/new-macos-starter/issues/new?template=feature_request.md)
- Want to contribute? [Submit a PR](https://github.com/larrykoo711/new-macos-starter/pulls)

## License

[MIT License](LICENSE) — Use it, modify it, ship it.

## Acknowledgments

Inspired by the engineering cultures at YC startups, Silicon Valley companies, and the open-source community.

---

<p align="center">
  <strong>Built with focus by engineers, for engineers.</strong>
</p>
