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
# install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "Close your terminal and reopen."
