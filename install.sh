#!/bin/bash
# create dirs
mkdir -p ~/.vim/tmp/{swap,backup,undo}

# create symlinks
ln -s ~/.vim/vimrc ~/.vimrc

# install Vundle
git clone git://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# install Plugins
vim +PluginInstall +qall
