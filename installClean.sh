# /bin/bash
# or
mkdir ~/.vim && touch ~/.vim/vimrc

# create symlinks
ln -s ~/.vim/vimrc ~/.vimrc

# create dirs
mkdir ~/.vim/tmp
cd ~/.vim/tmp
mkdir swap backup undo

# install Vundle
git clone git://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
cp ~/.vim/bundle/vundle/autoload ~/.vim

# install Plugins
vim +PluginInstall +qall

# install ycm
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer
