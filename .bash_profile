PS1="\[\033[33;1m\]\w\[\033[m\]:"
export TERM='xterm-256color'
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR=vim
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

if [ -n "$BASH" ] && [ -r ~/.bashrc ]; then
    . ~/.bashrc
fi

if [ -n "$BASH" ] && [ -r ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

[ -f ~/.fzf.bash ] && . ~/.fzf.bash

if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi
