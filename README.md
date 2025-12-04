# Dotfiles

Configuration files and Mac setup automation for quick machine setup.

## What's included

**Dotfiles:**

- `.zshrc` - Zsh configuration
- `.gitconfig` - Git configuration
- `starship.toml` - Starship prompt configuration
- `ghostty/config` - Ghostty terminal configuration

**Mac Setup:**

- `setup-mac.sh` - System preferences automation
- `Brewfile` - All installed apps and tools

## Setting up a new Mac

### 1. Run the Mac setup script

```bash
git clone git@github.com:seemaullal/seema-setup.git ~/Developer/seema-setup
cd ~/Developer/seema-setup
chmod +x setup-mac.sh
./setup-mac.sh
```

This will:

- Configure system preferences (scrolling, Dock, Finder, menu bar, etc.)
- Install Homebrew
- Install all apps from Brewfile

### 2. Set up dotfiles

```bash
./install.sh
```

Create `~/.zshrc.local` for any secrets/credentials

### Auto-sync

To automatically backup dotfile changes daily at 6 PM:

```bash
crontab -e
```

Add this line:

```
0 18 * * * cd ~/Developer/seema-setup && ./sync.sh >> ~/dotfiles-sync.log 2>&1
```

## Updating your setup

### Adding new system preferences

Edit `setup-mac.sh` to add new preferences.

### Adding new apps

After installing new apps via Homebrew:

```bash
cd ~/Developer/seema-setup
brew bundle dump --force
./sync.sh
```

### Syncing dotfile changes

Changes to dotfiles are automatically tracked. To manually sync:

```bash
cd ~/Developer/seema-setup
./sync.sh
```

## How it works

- **Dotfiles**: Symlinks point from your home directory to this repo, so changes are automatically tracked
- **Mac setup**: `setup-mac.sh` configures your Mac preferences with `defaults` commands
- **Apps**: `Brewfile` lists all Homebrew packages, casks, and Mac App Store apps
