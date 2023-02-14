#!/usr/bin/env sh

cd '/tmp' || exit
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage --appimage-extract
rm -rf $HOME/.local/bin/squashfs-root
mv squashfs-root $HOME/.local/bin

rm $HOME/.local/bin/vim
ln -s ./squashfs-root/usr/bin/nvim $HOME/.local/bin/vim

echo 'Done!'
