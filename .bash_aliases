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
alias cc='xclip -selection clipboard'

alias ag='rg -i --hidden'
alias dco='docker-compose'
alias rmpyc='sudo find . -name "*.pyc" -delete'
alias jq='python -m json.tool'
alias ls='ls --color=auto'
alias pgfes='pgcli postgres://festicket:festicket@127.0.0.1/festicket'
alias pgint='pgcli postgres://integrations:integrations@127.0.0.1/integrations'
alias al='alsamixer'

function todo() {
    vim ~/Notes/$(date '+%Y-%m-%d').md
}

function cls() {
    vim $(ag "class $1\(" --line-number | awk -F  ":" '{print $1":"$2}')
}

function fnc() {
    vim $(ag "def $1\(" --line-number | awk -F  ":" '{print $1":"$2}')
}

function br() {
    sudo vim /sys/class/backlight/acpi_video0/brightness
}

function v() {
    vim $1
}

function colorgrid() {
    iter=16
    while [ $iter -lt 52 ]
    do
        second=$[$iter+36]
        third=$[$second+36]
        four=$[$third+36]
        five=$[$four+36]
        six=$[$five+36]
        seven=$[$six+36]
        if [ $seven -gt 250 ];then seven=$[$seven-251]; fi

        echo -en "\033[38;5;$(echo $iter)m█ "
        printf "%03d" $iter
        echo -en "   \033[38;5;$(echo $second)m█ "
        printf "%03d" $second
        echo -en "   \033[38;5;$(echo $third)m█ "
        printf "%03d" $third
        echo -en "   \033[38;5;$(echo $four)m█ "
        printf "%03d" $four
        echo -en "   \033[38;5;$(echo $five)m█ "
        printf "%03d" $five
        echo -en "   \033[38;5;$(echo $six)m█ "
        printf "%03d" $six
        echo -en "   \033[38;5;$(echo $seven)m█ "
        printf "%03d" $seven

        iter=$[$iter+1]
        printf '\r\n'
    done
}
