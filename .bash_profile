export TERM='xterm-256color'
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export EDITOR=vim
export VISUAL=vim
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin
export PATH=~/.npm-global/bin:$PATH
export PATH=~/go/bin:$PATH
export PATH=~/.local/bin:$PATH
export LANG=en_US.UTF-8
#export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ '
#export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\[\033[01;34m\]\W\[\033[00m\]\$ '
[[ -f ~/.bashrc ]] && source ~/.bashrc
