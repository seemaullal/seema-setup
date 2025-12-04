# Dotfiles

Configuration files for quick machine setup

## What's included

- `.zshrc` - Zsh configuration
- `.gitconfig` - Git configuration
- `starship.toml` - Starship prompt configuration
- `ghostty/config` - Ghostty terminal configuration

## Setting up a new machine

```bash
git clone git@github.com:seemaullal/seema-setup.git ~/Developer/seema-setup
cd ~/Developer/seema-setup
./install.sh
```

Create `~/.zshrc.local` for any secrets/credentials

### Auto-sync

To automatically backup changes daily at 6 PM:

```bash
crontab -e
```

Add this line:

```
0 18 * * * cd ~/Developer/seema-setup && ./sync.sh >> ~/dotfiles-sync.log 2>&1
```

## Syncing changes

To manually sync anytime:

```bash
cd ~/Developer/seema-setup
./sync.sh
```
