# CLAUDE.md

Personal macOS dotfiles repository with automated symlink-based configuration management.

## Repository Overview

- **Purpose**: Complete macOS development environment setup with automated configuration management.
- **Approach**: Symlink-based dotfiles with backup system.
- **Git Repository**: `git@github.com:dvakatsiienko/.dotfiles.git`.
- **Scripting**: zx (Google's shell scripting utility) for automation.

## Directory Structure

```
.dotfiles/
├── source/                     # Configuration files to be symlinked
│   ├── .config/
│   │   ├── oh-my-zsh-custom/  # Custom zsh aliases and functions
│   │   └── starship.toml      # Starship prompt configuration
│   ├── .ssh/                  # SSH configuration (config, allowed_signers)
│   ├── iTerm2/                # iTerm2 configuration
│   ├── .zshrc .zprofile .zshenv  # Shell configuration
│   ├── .gitconfig             # Git configuration with 1Password
│   └── .vimrc                 # Vim configuration
├── script/                    # Installation automation
│   ├── install-macos.mjs      # macOS defaults + Homebrew setup
│   ├── install-dotfiles.mjs   # Backup + symlink creation
│   ├── list-symlinks.mjs      # List current symlinks status
│   ├── untrack-dotfile.mjs    # Convert symlink to real file
│   └── lib.mjs               # Colored terminal output utilities
├── themes/                    # Terminal and editor themes
│   ├── terminal/             # Gruvbox and Treehouse terminal themes
│   └── VSCode/               # Gruvbox VSCode themes
└── .claude/                  # Claude Code configuration
    └── settings.local.json   # Additional directory permissions
```

## Installation Process

### What the Scripts Do

**install-macos.mjs:**

- Sets macOS defaults (show hidden files, fast key repeat)
- Installs/verifies Homebrew and core CLI tools
- Sets up vim-plug plugin manager

**install-dotfiles.mjs:**

- Creates backup directories (`~/.dotfiles_backup`)
- Backs up existing dotfiles to prevent data loss
- Creates symlinks from `source/` to home directory and config locations

## Dotfiles Management

### Available Commands

```bash
pnpm list-symlinks           # List all current dotfiles symlinks with status
pnpm untrack-dotfile <file>  # Convert symlink to real file and remove from repo
```

### Safety Features

- **Backup system**: Original files backed up to `~/.dotfiles_backup/`
- **Validation checks**: Ensures required binaries are installed
- **Idempotent installation**: Safe to run multiple times
- **Interactive confirmation**: For destructive operations

## Key System Details

### Symlink Architecture

- Uses **symlinks**, not file copies (changes to source files immediately apply)
- Backup system prevents data loss during installation

### Configuration Files

- **Shell**: zsh with oh-my-zsh + custom aliases/functions in `source/.config/oh-my-zsh-custom/`
- **Git**: 1Password SSH signing integration
- **Terminal**: Starship prompt with gruvbox theme
- **Vim**: Gruvbox theme with essential plugins

### Aliases & Functions

Reference actual files for current aliases:

- Git workflows: `source/.config/oh-my-zsh-custom/aliases.zsh`
- Custom functions: `source/.config/oh-my-zsh-custom/functions.zsh`
- Includes both "vibe" theme git aliases and standard shortcuts

## Project Configuration

- **Engine requirements**: Node >=18.12.0, pnpm >=8.5.0
- **Dependencies**: zx for scripting
- **Code quality**: ESLint + Prettier with polished configs

## Claude Config Management (.clauderc)

### System Architecture

**Config Locations:**

- `~/.claude/` = Standard Claude Code config directory (symlink targets)
- `~/.dotfiles/.clauderc/` = Source of truth (original files, git tracked)
- `~/.dotfiles/.claude/` = Project-level claude configs for dotfiles project

**Symlink Flow:**

```
~/.claude/settings.json  → ~/.dotfiles/.clauderc/settings.json
~/.claude/.membank/      → ~/.dotfiles/.clauderc/.membank/
~/.claude/agents/        → ~/.dotfiles/.clauderc/agents/
~/.claude/commands/      → ~/.dotfiles/.clauderc/commands/
```

### Configuration Categories

**Claude Built-in Configs:**

- ✅ `settings.json` - Permissions, hooks, integrations
- ✅ `agents/` - Agent definitions (.md files)
- ✅ `commands/` - Command definitions (.md files)

**Custom Configs:**

- ✅ `.membank/` - Documentation, libsources, implementation guides
- ✅ `statusline/` - Statusline code and scripts
- ⚠️ `config/` - Legacy notification configs (needs cleanup)
- ⚠️ `scripts/` - Python libsource scripts (needs reformatting)
- ⚠️ `sounds/` - Audio notifications (needs cleanup)
- ❌ `agents.md` - Legacy subagents config (candidate for removal)

### Management Rules

**Source of Truth:** `.clauderc/` contains originals

- ✅ Edit files in `.clauderc/` only
- ✅ Changes automatically reflect via symlinks
- ❌ Never edit files in `~/.claude/` directly

**Backup Strategy:**

- ✅ Git tracks `.clauderc/` originals
- ❌ No automated dotfile scripts (manual management only)
- ✅ Symlinks preserve real-time sync

**Cache vs Config:**

- ✅ Conversation history, todos, thinking files stay in `~/.claude/`
- ✅ Only true configuration files stored in `.clauderc/`

### Current Structure

```
.clauderc/
├── settings.json          # Main Claude settings
├── .membank/              # Knowledge base system
├── agents/                # Agent definitions
├── commands/              # Command definitions
├── statusline/            # Statusline implementation
│   ├── statusline-db.json # Shared emoji rotation state
│   ├── statusline.sh      # Bash implementation
│   ├── statusline-go/     # Go implementation directory
│   │   ├── bin            # Compiled Go binary
│   │   ├── main.go        # Go source code
│   │   ├── go.mod         # Go module file
│   │   └── go.sum         # Go dependencies
│   ├── switch-to-go.sh    # Switch to Go version
│   └── switch-to-sh.sh    # Switch to Bash version
├── config/                # ⚠️ Needs cleanup
├── scripts/               # ⚠️ Needs reformatting
├── sounds/                # ⚠️ Needs cleanup
└── agents.md              # ❌ Legacy file
```

## Statusline System

### Overview
Dual-implementation statusline system providing rich terminal display with:
- Directory path with ~ shortening
- Dynamic model detection with rotating emoji (hourly rotation)
- Node.js and pnpm version display  
- Comprehensive git status: branch, sync indicators, file counts, line changes
- Stash count when present
- Day/night themed git emojis (🦔/🦦)

### Architecture
- **Shared State**: `statusline-db.json` tracks emoji rotation across implementations
- **Go Version**: High-performance compiled binary in `statusline-go/bin`
- **Bash Version**: Portable shell script `statusline.sh`
- **Switch Scripts**: Toggle between implementations seamlessly

### Features
- **Emoji Rotation**: 66 unique emojis rotate every hour
- **Git Sync Status**: Superscript ahead/behind indicators (↑¹ ↓²)
- **Error Handling**: Graceful fallbacks for missing tools
- **Dynamic Model**: Reads current model from settings.json
- **Rich Git Stats**: Staged/unstaged/untracked files with line counts

### Usage
- **Switch to Go**: `./switch-to-go.sh` (compiles if needed)
- **Switch to Bash**: `./switch-to-sh.sh`
- **Current**: Points to `statusline-go/bin` in settings.json

## Important Notes

- **1Password required** for SSH signing functionality
- **Vim plugins** require manual `:PlugInstall` after initial setup
- Repository optimized for Claude Code development workflows
