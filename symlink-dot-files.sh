#!/bin/bash
cwd=$(pwd)
ln -s $cwd/init.vim ~/.config/nvim/init.vim
ln -s $cwd/bash_profile ~/.bash_profile
ln -s $cwd/bashrc ~/.bashrc
ln -s $cwd/eslintrc ~/.eslintrc
ln -s $cwd/tmux.conf ~/.tmux.conf
ln -s $cwd/prettier-config.yml ~/.config/prettier/config.yml
