#!/bin/bash

#clone vundle which is a vim plugin manager (vim bundle
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

cd ~/.vim/plugin

if [ !-f ~/vim/plugin ]; then
	echo "~/vim/plugin does not exist"
	exit
fi
