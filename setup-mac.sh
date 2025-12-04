#!/bin/bash
# setup-mac.sh - Mac setup script matching Seema's preferences

set -e

echo "🚀 Starting Mac setup..."

# Close System Preferences to prevent conflicts
osascript -e 'tell application "System Preferences" to quit'

###############################################################################
# Scrolling & Trackpad                                                        #
###############################################################################

echo "⚙️  Configuring trackpad and scrolling..."

# Traditional scrolling (NOT natural)
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

###############################################################################
# Sound & Volume                                                              #
###############################################################################

echo "⚙️  Configuring sound..."

# Enable volume feedback when changing volume
defaults write com.apple.sound.beep.feedback -int 1

###############################################################################
# Menu Bar                                                                    #
###############################################################################

echo "⚙️  Configuring menu bar..."

# Show battery percentage
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Show WiFi, Bluetooth, and Battery in menu bar
defaults write com.apple.controlcenter "NSStatusItem Visible WiFi" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool true
defaults write com.apple.controlcenter "NSStatusItem Visible Battery" -bool true

###############################################################################
# Dock                                                                        #
###############################################################################

echo "⚙️  Configuring Dock..."

# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true

# Don't show recent applications
defaults write com.apple.dock show-recents -bool false

# Don't show process indicators
defaults write com.apple.dock show-process-indicators -bool false

###############################################################################
# Finder                                                                      #
###############################################################################

echo "⚙️  Configuring Finder..."

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Show sidebar
defaults write com.apple.finder ShowSidebar -bool true

# Use list view as default
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

###############################################################################
# Appearance                                                                  #
###############################################################################

echo "⚙️  Configuring appearance..."

# Dark mode
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"

###############################################################################
# Install Homebrew and apps                                                   #
###############################################################################

echo "🍺 Installing Homebrew..."

if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "Homebrew already installed"
fi

echo "📦 Installing apps from Brewfile..."
brew bundle install

###############################################################################
# Restart affected apps                                                       #
###############################################################################

echo "🔄 Restarting affected applications..."

killall Dock
killall Finder
killall SystemUIServer  # Refreshes menu bar
killall ControlCenter

echo ""
echo "✅ Mac setup complete!"
echo "Note: Some changes may require a logout/restart to take full effect."
