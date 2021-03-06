shopt -s expand_aliases  

alias pslist='ps aux | fzf'
alias gs='git status'
alias gd='git diff'
alias gc='git checkout'
alias gb='git branch | cut -c 3- | fzf | xargs git checkout'
alias gu='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias gp='git push'
alias gl='git pull'
alias ga='git add'
alias sg='git rev-parse --short=10 HEAD'
alias cc='xclip -selection clipboard'
alias k='kubectl'
alias o='xdg-open'
alias vim='nvim'

alias ag='rg -i --hidden'
alias rmpyc='sudo find . -name "*.pyc" -delete'
alias ls='ls --color=auto'

function venv() {
    virtualenv venv.`basename "$PWD"` -p python3
    source venv.`basename "$PWD"`/bin/activate
}

function v() {
    nvim $1
}

complete -F __start_kubectl k
