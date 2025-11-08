#!/bin/bash

echo "🚀 Starting MEGAVIM installation..."

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew already installed. Updating..."
    brew update
fi

# Install required packages
echo "Installing required packages..."
brew install neovim ripgrep fd git node rust rustup-init lldb python go stylua prettier black isort pylint eslint_d lazygit wezterm

# Install Rust toolchain
rustup-init -y

# Create necessary directories
echo "Creating Neovim configuration directories..."
mkdir -p ~/.config/nvim
mkdir -p ~/.config/wezterm

# Backup existing configurations
echo "Backing up existing configurations..."
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak

# Clone the Neovim configuration
echo "Cloning Neovim configuration..."
git clone https://github.com/yourusername/nvim-config.git ~/.config/nvim

# Setup Zsh configuration
echo "Setting up Zsh configuration..."
cat > ~/.zshrc << 'EOL'
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load
ZSH_THEME="robbyrussell"

# Plugins
plugins=(git node npm rust cargo docker)

source $ZSH/oh-my-zsh.sh

# Aliases
alias vim="nvim"
alias vi="nvim"
alias oldvim="vim"
alias lg="lazygit"

# NVM setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Rust
. "$HOME/.cargo/env"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# Python
export PATH=$PATH:$HOME/.local/bin
EOL

# Setup WezTerm configuration
echo "Setting up WezTerm configuration..."
cat > ~/.config/wezterm/wezterm.lua << 'EOL'
local wezterm = require 'wezterm'

return {
  font = wezterm.font('JetBrains Mono'),
  font_size = 14.0,
  color_scheme = 'Tokyo Night',
  window_background_opacity = 0.95,
  hide_tab_bar_if_only_one_tab = true,
  window_padding = {
    left = 2,
    right = 2,
    top = 2,
    bottom = 2,
  },
  keys = {
    -- Add your custom keybindings here
  },
}
EOL

# Install Oh My Zsh
echo "Installing Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install Node Version Manager (nvm)
echo "Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash

# Install latest LTS version of Node.js
echo "Installing Node.js LTS..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts

# Install Python packages
echo "Installing Python packages..."
pip3 install --user pynvim

# Download and install a Nerd Font
echo "Installing JetBrains Mono Nerd Font..."
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font

# Final setup
echo "Running final setup..."
nvim --headless "+Lazy sync" +qa

echo "🎉 Installation complete! Please restart your terminal and run 'nvim' to start using MEGAVIM."
echo "Note: Some LSP servers and tools will be installed on first launch."
