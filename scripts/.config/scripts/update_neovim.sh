#!/usr/bin/env sh

cd /tmp
wget https://github.com/neovim/neovim/releases/download/v0.7.2/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage $HOME/.local/bin/vim

echo 'Done!'
