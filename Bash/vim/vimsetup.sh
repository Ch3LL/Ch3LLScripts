#!/bin/bash

#Get all the plugins
WGET='wget -P /tmp/'
VIMRC='https://raw.githubusercontent.com/cbodden/dotfiles/master/vim/.vimrc'
SOLARIZED='https://raw.githubusercontent.com/altercation/solarized/master/vim-colors-solarized/colors/solarized.vim' 
VUNDLE='git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim'
#RAINBOW='http://www.vim.org/scripts/download_script.php?src_id=4007'
PATHOGEN='https://tpo.pe/pathogen.vim'


#VIM Directories
VIMFILES=("$HOME/.vim/backup" "$HOME/.vim/colors" "$HOME/.vim/tmp" "$HOME/.vim/plugin" "$HOME/.vim/autoload" "$HOME/.vim/bundle")

echo "Creating necessary directories"
for i in "${VIMFILES[@]}"; do
	if [ ! -d $i ]; then
		echo "Creating the $i direcotyr"
		mkdir -p $i
	else
		echo "The $i directory is already there"
	fi
done

function filecheck () {
	IFILE=$1
	COMMAND=$2
	DFILE=$3
	FDIR=$4
	FDIFF="diff -u $IFILE $DFILE" > /dev/null
	if [ ! -f $IFILE ]; then
		echo $IFILE does not exist. Wgetting the file
		$COMMAND 
		mv $DFILE $FDIR
	else 
		echo $IFILE already exists. Going to download the file and check if the file needs to be updated.
		$COMMAND
		$FDIFF 
		if [ $? -eq 0 ]; then
			echo "The files are the same. No need to update file."
			echo "Deleting downloaded file"
			rm -rf $DFILE
		else
			echo "The files are not the same. Moving the new version over"
			mv $DFILE $FDIR
		fi	
	fi

}

#The filecheck command is as follows -> filecheck <filetocheckifpluginalreadyinstalled> <commandtoinstallplugin> </tmp/nameoffile> <directoryofcurrentlyinstalledplugin> 
echo "Now we are going to install plugins and the vimrc file"
filecheck "$HOME/.vim/autoload/pathogen.vim" "$WGET $PATHOGEN" "/tmp/pathogen.vim" "$HOME/.vim/autoload/"
#filecheck "$HOME/.vimrc" "$WGET $VIMRC" '/tmp/.vimrc' "$HOME"
filecheck "$HOME/.vim/colors/solarized.vim" "$WGET $SOLARIZED" '/tmp/solarized.vim' "$HOME/.vim/colors/"
#filecheck "$HOME/.vim/plugin/RainbowParenthsis.vim" "$WGET/RainbowParenthsis.vim $RAINBOW" '/tmp/RainbowParenthsis.vim' "$HOME/.vim/plugin/"


#I got lazy at this point and will add these installs to the function later. For now I just wanted to get everything working.

#nerdtree
cd "$HOME/.vim/bundle"
git clone https://github.com/scrooloose/nerdtree.git 

#Vundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
mv ~/.vim/bundle/Vundle.vim/ ~/.vim/bundle/vundle

#Install Plugins
vim +BundleInstall +qall

echo "Your done"
