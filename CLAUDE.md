# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository for macOS development setup, focused on iOS/Swift development with Neovim, Ruby, Node.js, and Python tooling.

## Key Commands

### Setup and Installation
- `make links` - Create symbolic links for configuration files (nvim, Brewfile, zprofile)
- `make clean` - Remove all symbolic links
- `make ruby` - Install Ruby 3.4.4 via rbenv and gems
- `make node` - Install Node.js v22.17.0 via nvm and packages
- `make nvm` - Install nvm from official source
- `make pipx` - Install Python packages via pipx (pre-commit, pymobiledevice3)

### Code Quality
- `pre-commit run --all-files` - Run all pre-commit hooks (StyLua, shellcheck, YAML checks)
- `shellcheck scripts/*.sh` - Lint shell scripts

## Architecture

### Core Structure
- **scripts/**: Shell scripts for environment setup
  - `symlinks.sh` - Creates/removes symbolic links for config files
  - `node.sh` - Node.js and npm package installation
  - `ruby.sh` - Ruby and gem installation
  - `pipx.sh` - Python package installation
- **nvim/**: Neovim configuration with lazy loading
  - Swift development focus with sourcekit LSP and xcodebuild.nvim
  - Modular Lua configuration structure
- **Brewfile**: Homebrew dependencies for macOS development
- **zprofile**: Shell environment setup (rbenv, jenv, nvm, pipx)

### Development Environment
- **Swift/iOS**: Configured with sourcekit LSP, xcodebuild.nvim, xcbeautify
- **Multiple language support**: Ruby (rbenv), Node.js (nvm), Java (jenv), Python (pipx)
- **Pre-commit hooks**: StyLua for Lua, shellcheck for shell scripts, YAML validation

### Symbolic Link Management
The repository uses a centralized symlink system where configuration files are linked to their expected locations:
- `nvim/` → `~/.config/nvim`
- `Brewfile` → `~/Brewfile`
- `zprofile` → `~/.zprofile`

## Important Notes

- All shell scripts follow shellcheck standards
- Neovim configuration is modular with lazy loading via lazy.nvim
- Environment supports multiple Java versions via jenv
- Pre-commit hooks ensure code quality before commits
- Repository includes Claude Code as a global npm package installation
