shopt -s expand_aliases  

alias pslist='ps aux | fzf'
alias deletebranches='git branch | grep -v "production" | xargs git branch -D'
alias gs='git status'
alias gd='git diff'
alias gc='git checkout'
alias gb='git branch | cut -c 3- | pick | xargs git checkout'
alias gu='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias gp='git push'
alias gl='git pull'
alias gr='git rebase'
alias ga='git add'
alias sg='git rev-parse --short=10 HEAD'
alias t='vim ~/.tasks'
alias n='vim ~/.notes'

alias swap='kubectl config use-context'
alias k='kubectl'
alias ag='rg -i --hidden'
alias dc='docker-compose'
alias rmpyc='sudo find . -name "*.pyc" -delete'
alias jq='python -m json.tool'
alias l='ls'
alias pgcli='pgcli postgres://festicket:festicket@127.0.0.1/festicket'

function cls() {
    vim $(ag "class $1\(" --line-number | awk -F  ":" '{print $1":"$2}')
}

function fnc() {
    vim $(ag "def $1\(" --line-number | awk -F  ":" '{print $1":"$2}')
}

function vim() {
    printf "\e]1;"`basename "$1"`"\a"
    /usr/local/bin/vim $1
}

function v() {
    printf "\e]1;"`basename "$1"`"\a"
    /usr/local/bin/vim $1
}

if [ $ITERM_SESSION_ID ]; then
  export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; ':"$PROMPT_COMMAND";
fi
