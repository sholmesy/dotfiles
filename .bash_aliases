alias pslist='ps aux | fzf'
alias deletebranches='git branch | grep -v "production" | xargs git branch -D'
alias gs='git status'
alias gd='git diff'
alias gb='git branch'
alias gc='git checkout'
alias gu='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias gp='git push'
alias gl='git pull'
alias gr='git rebase'
alias ga='git add'
alias sg='git rev-parse --short=10 HEAD'
alias work='vim ~/.work'
alias me='vim ~/.me'

alias swap='kubectl config use-context'
alias k='kubectl'
alias ag='rg -i'
alias dc='docker-compose'
alias sed='gsed'
alias rmpyc='sudo find . -name "*.pyc" -delete'
alias jq='python -m json.tool'
alias l='ls'

function vim() {
    printf "\e]1;"`basename "$1"`"\a"
    /usr/local/bin/vim $1
}

if [ $ITERM_SESSION_ID ]; then
  export PROMPT_COMMAND='echo -ne "\033];${PWD##*/}\007"; ':"$PROMPT_COMMAND";
fi
