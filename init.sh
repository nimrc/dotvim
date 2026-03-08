#!/usr/bin/env bash

set -e

# Backup existing config if present
if [ -d "$HOME/.vim" ] || [ -f "$HOME/.vimrc" ]; then
    echo "Backing up existing vim config..."
    timestamp=$(date +%Y%m%d%H%M%S)
    [ -d "$HOME/.vim" ] && mv "$HOME/.vim" "$HOME/.vim.bak.$timestamp"
    [ -f "$HOME/.vimrc" ] && mv "$HOME/.vimrc" "$HOME/.vimrc.bak.$timestamp"
fi

echo "Cloning dotvim..."
git clone --depth=1 https://github.com/nimrc/dotvim.git "$HOME/.vim"

echo "Installing vim-plug..."
curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Symlinking .vimrc..."
ln -sf "$HOME/.vim/.vimrc" "$HOME/.vimrc"

echo "Installing plugins..."
vim -E -s +PlugInstall +qall || echo "Plugin installation finished with warnings (likely from first run)"

echo "Install complete!"
