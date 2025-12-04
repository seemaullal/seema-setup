#!/bin/bash
# install.sh - Sets up dotfiles by creating symlinks

set -e

DOTFILES_DIR="$HOME/Developer/seema-setup"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

echo "Setting up dotfiles from $DOTFILES_DIR"

# Create backup directory
mkdir -p "$BACKUP_DIR"

# Function to create symlink
create_symlink() {
    local source="$1"
    local target="$2"
    
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "Backing up existing $target"
        mv "$target" "$BACKUP_DIR/"
    fi
    
    if [ -L "$target" ]; then
        rm "$target"
    fi
    
    echo "Linking $source -> $target"
    ln -s "$source" "$target"
}

# Create .config directory if it doesn't exist
mkdir -p "$HOME/.config"

# Link config files
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
create_symlink "$DOTFILES_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
create_symlink "$DOTFILES_DIR/.config/ghostty" "$HOME/.config/ghostty"

echo ""
echo "🔤 Installing fonts..."
# Copy fonts to user fonts directory
cp -f "$DOTFILES_DIR/fonts/"*.ttf ~/Library/Fonts/ 2>/dev/null || true
cp -f "$DOTFILES_DIR/fonts/"*.otf ~/Library/Fonts/ 2>/dev/null || true
echo "Fonts installed to ~/Library/Fonts"

echo ""
echo "✅ Dotfiles setup complete!"
echo "Backups saved to: $BACKUP_DIR"
echo ""
echo "📝 Don't forget to create ~/.zshrc.local for your secrets/credentials!"
