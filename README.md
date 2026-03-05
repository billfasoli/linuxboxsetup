# Linux Box Setup

A script to quickly configure a fresh Linux installation with my preferred terminal setup: zsh, tmux, Oh My Zsh, and Powerlevel10k with 24-bit true color support.

## Quick Start

Run this single command on a fresh Linux box:

```bash
curl -fsSL https://raw.githubusercontent.com/billfasoli/linuxboxsetup/main/install.sh | bash
```

Or, if you prefer to review the script first:

```bash
curl -fsSL https://raw.githubusercontent.com/billfasoli/linuxboxsetup/main/install.sh -o install.sh
less install.sh
bash install.sh
```

The script will automatically launch zsh with the new configuration when complete.

### Prerequisites

- `git`, `curl`, and `sudo` must be available
- Run as a regular user (not root)

## What the Script Does

The install script automates the following:

### 1. Install tmux
Terminal multiplexer for managing multiple terminal sessions in one window.

### 2. Install zsh
A powerful shell with better autocompletion and customization than bash.

### 3. Set zsh as default shell
Runs `chsh -s $(which zsh)` to make zsh your login shell.

### 4. Install Oh My Zsh
Framework for managing zsh configuration with themes and plugins.

### 5. Install Powerlevel10k
A fast and highly customizable zsh theme with git status, command execution time, and more.

### 6. Install zsh plugins
- **zsh-autosuggestions** - Suggests commands as you type based on history
- **zsh-syntax-highlighting** - Highlights valid commands in green, errors in red

### 7. Install Nerd Font
Installs `Fura Mono Regular Nerd Font Complete.otf` to `~/.local/share/fonts` for Powerlevel10k icons.

### 8. Copy configuration files
Installs the following config files to your home directory:
- `.zshrc` - zsh configuration with 24-bit color support
- `.p10k.zsh` - Powerlevel10k theme configuration
- `.tmux.conf` - tmux configuration with 24-bit color support
- `.nanorc` - nano editor configuration

Existing config files are backed up with a `.backup` extension.

### 9. Install tmux plugin manager (TPM)
After setup, press `Ctrl+B` then `I` inside tmux to install tmux plugins.

## Configuration Highlights

- **24-bit true color** enabled in both zsh and tmux
- **Mouse mode** enabled in tmux
- **tmux auto-starts** when opening a terminal
- **Public IP and timestamp** displayed in tmux status bar
- **Window/pane numbering** starts at 1 (not 0)

## Post-Installation

1. Set your terminal emulator to use "FuraMono Nerd Font"
2. In tmux, press `Ctrl+B` then `I` to install plugins
