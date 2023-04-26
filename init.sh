#!/bin/bash

# ***************************
# ******  dot files *********
# ***************************
#
# Create config directories
mkdir -p ~/.config
mkdir -p ~/.config/nvim
mkdir -p ~/.config/prettier

./symlink-dot-files.sh

# ***************************
# ****** Brew Install *******
# ***************************

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew upgrade
brew tap Homebrew/bundle
brew bundle
brew cleanup

# The rest is in Brewfile

# ********************
# ****** Python ******
# ********************

# Python global packages
pip3 install pynvim

# ********************
# ****** NodeJS ******
# ********************

# Node Version Manager (NVM)
mkdir ~/.nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
. ~/.nvm/nvm.sh
nvm install node

# NPM global packages
npm install -g eslint
npm install -g eslint-plugin-react
npm install -g prettier
npm install -g neovim

# Vim - Plug
#curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    #https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


#nvim +PlugInstall +UpdateRemotePlugins +qa

# ***************************
# ****** Configure Zsh ******
# ***************************

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

pull_or_clone() {
  RED='\033[0;31m'
  GREEN='\033[0;32m'
  CYAN='\033[0;36m'
  NC='\033[0m'

  target_folder=$1
  repo_url=$2

  if [ -d "$target_folder" ]; then
    printf "${CYAN}Repository folder exists. Pulling changes...\n${NC}"
    git -C "$target_folder" pull
  else
    printf "${CYAN}Repository folder does not exist. Cloning repository...\n${NC}"
    git clone --depth=1 "$repo_url" "$target_folder"
  fi
}

PLUGINS=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins
THEMES=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes

# Zsh Plugins
pull_or_clone $PLUGINS/zsh-syntax-highlighting "https://github.com/zsh-users/zsh-syntax-highlighting.git" 
pull_or_clone $PLUGINS/zsh-autosuggestions "https://github.com/zsh-users/zsh-autosuggestions.git" 
pull_or_clone $PLUGINS/zsh-completions "https://github.com/zsh-users/zsh-completions.git" 

# ZSH Themes
pull_or_clone $THEMES/powerlevel10k "https://github.com/romkatv/powerlevel10k.git"

printf "${CYAN}Don't forget to install a nerd font! (https://github.com/romkatv/powerlevel10k/blob/master/font.md)\n${NC}"

printf "${GREEN}Close your terminal and reopen.\n${NC}"
