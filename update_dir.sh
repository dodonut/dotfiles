#!/bin/bash
cp -rvf ~/.i3/* ./i3/

cp -v ~/.config/nvim/init.vim ~/.config/nvim/coc-settings.json ./nvim/

cp -rv ~/.config/lf/* ./config/lf/ 

read -p 'Upload to git? [Y]es or N[o] ' ans

if [[ $ans == 'yes'  || "$ans" == 'y' || "$ans" == 'Yes' ]]; then
	read -p 'Message: [empty] ' msg

	git add . && 
	git commit -m ${msg:-'update dotfiles'} &&
	git push origin master 
else
    echo 'No git upload'
fi
