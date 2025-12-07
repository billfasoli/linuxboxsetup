#!/bin/bash

# Linux Box Setup Script
# Automates installation of tmux, zsh, oh-my-zsh, powerlevel10k, and config files

set -e  # Exit on any error

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=== Linux Box Setup Script ==="
echo ""

# Check if running as root (we need sudo for some commands)
if [ "$EUID" -eq 0 ]; then
    echo "Please run this script as a regular user (not root). It will use sudo when needed."
    exit 1
fi

# Install tmux
echo "[1/8] Installing tmux..."
if ! command -v tmux &> /dev/null; then
    sudo apt update
    sudo apt install -y tmux
    echo "      tmux installed."
else
    echo "      tmux already installed, skipping."
fi

# Install zsh
echo "[2/8] Installing zsh..."
if ! command -v zsh &> /dev/null; then
    sudo apt install -y zsh
    echo "      zsh installed."
else
    echo "      zsh already installed, skipping."
fi

# Make zsh the default shell
echo "[3/8] Setting zsh as default shell..."
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)"
    echo "      zsh set as default shell. (Requires logout/login to take effect)"
else
    echo "      zsh is already the default shell."
fi

# Install Oh My Zsh
echo "[4/8] Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    # RUNZSH=no prevents oh-my-zsh from launching zsh after install
    RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "      Oh My Zsh installed."
else
    echo "      Oh My Zsh already installed, skipping."
fi

# Set ZSH_CUSTOM if not already set
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Install Powerlevel10k theme
echo "[5/8] Installing Powerlevel10k theme..."
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
    echo "      Powerlevel10k installed."
else
    echo "      Powerlevel10k already installed, skipping."
fi

# Install zsh plugins
echo "[6/8] Installing zsh plugins..."
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    echo "      zsh-autosuggestions installed."
else
    echo "      zsh-autosuggestions already installed, skipping."
fi

if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    echo "      zsh-syntax-highlighting installed."
else
    echo "      zsh-syntax-highlighting already installed, skipping."
fi

# Install Nerd Font
echo "[7/8] Installing Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts"
FONT_FILE="Fura Mono Regular Nerd Font Complete.otf"
if [ ! -f "$FONT_DIR/$FONT_FILE" ]; then
    mkdir -p "$FONT_DIR"
    cp "$SCRIPT_DIR/$FONT_FILE" "$FONT_DIR/"
    fc-cache -fv > /dev/null 2>&1
    echo "      Nerd Font installed."
else
    echo "      Nerd Font already installed, skipping."
fi

# Copy configuration files
echo "[8/8] Installing configuration files..."

# Backup existing configs if they exist
backup_if_exists() {
    if [ -f "$1" ] && [ ! -L "$1" ]; then
        echo "      Backing up existing $1 to $1.backup"
        mv "$1" "$1.backup"
    elif [ -L "$1" ]; then
        rm "$1"
    fi
}

backup_if_exists "$HOME/.zshrc"
backup_if_exists "$HOME/.p10k.zsh"
backup_if_exists "$HOME/.nanorc"
backup_if_exists "$HOME/.tmux.conf"

cp "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
cp "$SCRIPT_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
cp "$SCRIPT_DIR/.nanorc" "$HOME/.nanorc"
cp "$SCRIPT_DIR/.tmux.conf" "$HOME/.tmux.conf"

echo "      Configuration files installed."

# Install tmux plugin manager
echo ""
echo "Installing tmux plugin manager (TPM)..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    echo "      TPM installed. Press prefix + I in tmux to install plugins."
else
    echo "      TPM already installed."
fi

echo ""
echo "=== Setup Complete! ==="
echo ""
echo "Next steps:"
echo "  1. Log out and log back in (or reboot) for shell changes to take effect"
echo "  2. Set your terminal emulator to use the 'FuraMono Nerd Font' font"
echo "  3. In tmux, press Ctrl+B then I to install tmux plugins"
echo ""
echo "Your old config files (if any) have been backed up with .backup extension"
