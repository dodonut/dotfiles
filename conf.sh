mkdir $HOME/.config/nvim
cp init.vim $HOME/.config/nvim
apt-get update
apt-get install python3-pip -y
apt-get install neovim -y
pip3 install neovim
cd $HOME/.config/nvim/repos/github.com/junegunn/fzf
./install --all


mkdir $HOME/Desktop/codes
cd $HOME/Desktop/codes
git init
git remote add origin http://github.com/toomanysand/codes
git pull origin master
nvim
