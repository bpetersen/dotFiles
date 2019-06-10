#!/bin/bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew install neovim
brew install tmux
brew install git bash-completion
brew install bash-git-prompt
brew install the_silver_searcher
brew install python

pip3 install pynvim

# Node Version Manager (NVM)
mkdir ~/.nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install node
npm install -g eslint
npm install -g eslint-plugin-react
npm install -g prettier

# Vim - Plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/.config
mkdir -p ~/.config/nvim
mkdir -p ~/.config/prettier

./symlink-dot-files.sh

nvim +PlugInstall +UpdateRemotePlugins +qa

echo "Close your terminal and reopen."
