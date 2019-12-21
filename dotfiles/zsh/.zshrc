# Path to your oh-my-zsh installation.
export ZSH=/home/ch3ll/.oh-my-zsh

#ZSH_THEME: If it is listed here it is one of my fav themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

plugins=(git, git-fast, git-extras, vagrant)
export PATH="/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/home/ch3ll/.local/bin:/home/ch3ll/bin:/home/ch3ll/.local/bin:/home/ch3ll/bin:/home/linuxbrew/.linuxbrew/bin"
source $ZSH/oh-my-zsh.sh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH="/usr/local/rbenv/plugins/ruby-build/bin:/usr/local/rbenv/bin:$PATH"
source <(rbenv init -)
export EDITOR=/usr/bin/vim
