#!/bin/bash
#Super simple script to install vundle and pathogen
vimrcpath=~/.vimrc
vimrcurl=https://raw.githubusercontent.com/Ch3LL/Ch3LLScripts/master/vim/vimrc
autodir=~/.vim/autoload
bundledir=~/.vim/bundle
vundleurl=https://github.com/VundleVim/Vundle.vim.git
pathurl=https://tpo.pe/pathogen.vim
vundlevim=${bundledir}/Vundle.vim
pathvim=${autodir}/pathogen.vim 

dirs=($autodir $bundledir)
for dir in ${dirs[*]};do
	[[ ! -d $dir ]] && mkdir $dir
done

#=======Install all dem things========#
echo "Installing Vundle"
git clone $vundleurl $vundlevim
echo "Installing Pathogeon"
curl -LSso $pathvim $pathurl

#========VIMRC time========#
echo "Grabbing most recent vimrc file"
wget $vimrcurl -O $vimrcpath
echo "Installing all of the vundle plugins"
vim +PluginInstall +qall

