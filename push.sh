#!/bin/bash
cp -rvf ~/.i3/* ./i3/

cp -v ~/.config/nvim/init.vim ~/.config/nvim/coc-settings.json ./nvim/

cp -rv ~/.config/lf/* ./config/lf/ 

git add . && 
git commit -m ${1:-'update dotfiles'} &&
git push origin master 
