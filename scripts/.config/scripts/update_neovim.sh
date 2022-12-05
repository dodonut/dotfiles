#!/usr/bin/env sh

cd '/tmp' || exit
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
mv squashfs-root $HOME/.local/bin
ln -s ./squashfs-root/usr/bin/nvim vim

echo 'Done!'
