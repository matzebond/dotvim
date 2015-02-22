dotvim
===============

install from git
- git clone git://github.com/matzebond/dotvim.git ~/.vim

will create a symlink from ~/.vimrc to ~/.vim/vimrc and update plugins
- ~/.vim/install.sh

install ycm
- sudo apt-get install build-essential cmake
- sudo apt-get install python-dev

download clang or "sudo apt-get install libclang1-3.5"
- mkdir ~/ycm_build && cd ~/ycm_build

enter the path of the llvm+clang
- cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=PATH_TO_THE_LOADED_LLVM . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/

or when using system libs
- cmake -G "Unix Makefiles" -DUSE_SYSTEM_LIBCLANG=ON . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/

finally
- make ycm_support_libs
