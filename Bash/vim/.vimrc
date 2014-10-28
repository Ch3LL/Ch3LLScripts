"Thanks to
"https://raw.githubusercontent.com/cbodden/dotfiles/master/vim/.vimrc

" Basics {
  set background=dark " we plan to use a dark background
  set nocompatible "explicity get out of vi-compatible mode
  set noexrc " don't use local version of .(g)vimrc,exrc
  syntax on " syntax highlighting on
" }

" General {
  set backup " make backup files
  set backupdir=~/.vim/backup " where to put backup files
  set clipboard+=unnamed " share windows clipboard
  set directory=~/.vim/tmp " directory to place swap files in
  set fileformats=unix,dos,mac " support all three in this order
  set history=1000 " how many lines of history VIM has to remember
  set pastetoggle=<F2> " when insert mode, press f2 for paste mode
" }

" Vim UI {
  colorscheme solarized
  set background=dark " always keep background dark regardless of color theme
  set cursorline " highlight current line
  set hlsearch " highlight searches for phrases
  set incsearch " BUT do highlight as you type your search phrase
  set laststatus=2 " always show the status line
  set number " turn on line numbers
  set report=0 " tell us when anything is changed via :...
  set ruler " Always show current position along the bottom
  set showmatch " show matching brackets
" }

" Text Formating/Layout {
  set ignorecase " case insensitive by default
" }

" Plugin Settings {

" }
