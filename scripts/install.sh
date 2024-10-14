#!/bin/bash

if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>~/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew is already installed. Updating..."
  brew update
fi

echo "Installing dependencies..."
brew install zsh fzf zoxide nvm pnpm jq lazygit tmux neovim
brew install --cask font-jetbrains-mono-nerd-font

read -p "Install  alacritty? (y/n) " choice
[[ "$choice" == "y" ]] && brew install --cask alacritty

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  echo "Oh My Zsh is already installed."
fi

if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
  echo "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
  echo "Powerlevel10k is already installed."
fi

echo "Installing Zsh plugins..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting &>/dev/null
git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions &>/dev/null

echo "Binding .zshrc, .tmux.conf"
cp ~/.zshrc ~/.zshrc.bak.$(date +"%Y-%m-%d_%H-%M-%S")
cp ~/.tmux.conf ~/.tmux.conf.bak.$(date +"%Y-%m-%d_%H-%M-%S")
ln -sf ~/.config/dotfiles/.zshrc ~/.zshrc
ln -sf ~/.config/dotfiles/.tmux.conf ~/.tmux.conf

echo "Installation complete!"
echo "run source ~/.zshrc"
