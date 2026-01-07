# ===================
# .zprofile
# ===================
# This file is sourced by login shells before .zshrc
# Keep this minimal - only PATH and environment setup that must run early

# ===================
# Homebrew
# ===================
# Apple Silicon
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
# Intel
elif [[ -f "/usr/local/bin/brew" ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# ===================
# Language
# ===================
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# ===================
# Editor
# ===================
export EDITOR="code"
export VISUAL="code"
