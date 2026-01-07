# Contributing to macOS Starter

First off, thank you for considering contributing to macOS Starter! It's people like you that make this project such a great tool for the developer community.

## Code of Conduct

This project and everyone participating in it is governed by our [Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check the existing issues to avoid duplicates. When you create a bug report, include as many details as possible:

- **Use a clear and descriptive title**
- **Describe the exact steps to reproduce the problem**
- **Describe the behavior you observed and what you expected**
- **Include your macOS version and architecture** (Intel or Apple Silicon)
- **Include relevant logs or error messages**

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion:

- **Use a clear and descriptive title**
- **Provide a detailed description of the suggested enhancement**
- **Explain why this enhancement would be useful**
- **List any alternatives you've considered**

### Pull Requests

1. **Fork the repo** and create your branch from `main`
2. **Follow the existing code style** and conventions
3. **Update documentation** if you're changing functionality
4. **Test your changes** on your own macOS machine
5. **Write a clear commit message** describing your changes

## Development Guidelines

### File Structure

```
macOS-Starter/
├── scripts/          # Automation scripts
├── configs/          # Configuration files
└── docs/             # Documentation (Markdown)
```

### Script Guidelines

- Use `#!/bin/bash` for shell scripts
- Include error handling with `set -e`
- Add comments explaining non-obvious logic
- Use functions for reusable code blocks
- Test on both Apple Silicon and Intel if possible

### Documentation Guidelines

- Use clear, concise language
- Include code examples where helpful
- Keep the numbered chapter structure (01-09)
- Update the README if adding new features

### Brewfile Guidelines

When adding packages to the Brewfile:

```ruby
# Good - includes comment explaining the tool
brew "ripgrep"   # Better grep replacement

# Bad - no context
brew "rg"
```

### Commit Messages

Follow conventional commit format:

```
type: short description

Longer description if needed.
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Formatting, no code change
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

Examples:
```
feat: add support for Bun package manager
docs: update Python section with uv examples
fix: correct Homebrew path for Intel Macs
```

## Testing Your Changes

Before submitting a PR:

1. **Test the bootstrap script** on a fresh or existing macOS installation
2. **Verify Brewfile** with `brew bundle check --file=scripts/Brewfile`
3. **Run shellcheck** on shell scripts: `shellcheck scripts/*.sh`
4. **Check documentation** links are working

## Questions?

Feel free to open an issue with the "question" label if you have any questions about contributing.

## Recognition

Contributors will be recognized in our README. Thank you for helping make macOS Starter better!
