mkdir $HOME/.config/nvim
cp init.vim $HOME/.config/nvim
apt-get update
apt-get install neovim -y
./$HOME/.config/nvim/repos/github.com/junegunn/fzf/install -y -y -y


mkdir $HOME/Desktop/codes
cd $HOME/Desktop/codes
git init
git remote add origin http://github.com/toomanysand/codes
git pull origin master