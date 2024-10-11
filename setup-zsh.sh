#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# 1. Install Zsh
echo "Installing Zsh..."
if ! command_exists zsh; then
    sudo apt update
    sudo apt install -y zsh
else
    echo "Zsh is already installed."
fi

# Set Zsh as default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Setting Zsh as the default shell..."
    chsh -s $(which zsh)
else
    echo "Zsh is already the default shell."
fi

# 2. Install Oh My Zsh (if not installed)
echo "Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh is already installed."
fi

# 3. Install Zsh Syntax Highlighting
echo "Installing Zsh Syntax Highlighting..."
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
    echo "Zsh Syntax Highlighting is already installed."
fi

# 4. Install Zsh Autosuggestions
echo "Installing Zsh Autosuggestions..."
if [ ! -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
else
    echo "Zsh Autosuggestions is already installed."
fi

# 5. Install Powerlevel10k (p10k) theme
echo "Installing Powerlevel10k theme..."
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
    echo "Powerlevel10k theme is already installed."
fi

# 6. Update ~/.zshrc to include the plugins and theme
echo "Updating ~/.zshrc to enable plugins and theme..."
sed -i 's/ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc

# 7. Source ~/.zshrc to apply changes
echo "Sourcing ~/.zshrc to apply changes..."
source ~/.zshrc

echo "Installation complete! Restart your terminal or run 'zsh' to switch to the new shell."

