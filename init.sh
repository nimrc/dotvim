#!/usr/bin/env bash

rm -rf ~/.vim ~/.vimrc
git clone --depth=1 https://github.com/fyibmsd/dotvim.git ~/.vim

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

cd ~/.vim
ln -s ~/.vim/.vimrc ~/.vimrc
vim +PlugInstall +q! +q!

echo "Install complete!"
