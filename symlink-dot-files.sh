#!/bin/bash
cwd=$(pwd)
ln -s $cwd/init.lua ~/.config/nvim/init.lua
ln -s $cwd/bash_profile ~/.bash_profile
ln -s $cwd/bashrc ~/.bashrc
ln -s $cwd/eslintrc ~/.eslintrc
ln -s $cwd/tmux.conf ~/.tmux.conf
ln -s $cwd/prettier-config.yml ~/.config/prettier/config.yml
ln -s $cwd/zshrc ~/.zshrc
ln -s $cwd/p10k.zsh ~/.p10k.zsh
ln -s $cwd/Brewfile ~/Brewfile
