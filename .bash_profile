export TERM='xterm-256color'
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR=vim
export GOPATH=$HOME/go
export GOROOT=/usr/local/bin/go
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:/snap/bin
export PATH=~/.npm-global/bin:$PATH
#export PS1="~ "
#export PS1='$(whoami)@$(hostname):$(pwd)'
export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '


[[ -f ~/.bashrc ]] && source ~/.bashrc
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
[ -f /usr/share/autojump/autojump.bash ] && source /usr/share/autojump/autojump.bash
neofetch
xset r rate 180 40
