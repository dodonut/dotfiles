#!/usr/bin/env sh

cd '/tmp' || exit
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage $HOME/.local/bin/vim

echo 'Done!'
