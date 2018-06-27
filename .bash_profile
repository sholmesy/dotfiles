export TERM='xterm-256color'
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR=vim
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PS1="\[\033[01;38;5;007m\]$PS1\[\033[0m\]"

[[ -f ~/.bashrc ]] && source ~/.bashrc
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases
[ -f /etc/profile.d/autojump.sh ] && . /etc/profile.d/autojump.sh
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
