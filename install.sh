#!/bin/sh

sudo apt remove vim neovim
sudo apt install curl ##neovim

#cp .vimrc ~/
mkdir -p ~/.config/nvim
cp init.vim ~/.config/nvim/init.vim

#install neovim from appimage
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage #run to check 
sudo mv nvim.appimage /usr/local/bin/nvim

# install plugin manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# deno
curl -fsSL https://deno.land/install.sh | sh

# install npm
#curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
#sudo apt install nodejs npm
#sudo npm install -g vim-language-server
#sudo npm install -g pyright
#

