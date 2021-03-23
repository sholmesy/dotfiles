# Sensible Bash - An attempt at saner Bash defaults
# Maintainer: mrzool <http://mrzool.cc>
# Repository: https://github.com/mrzool/bash-sensible
# Version: 0.2.2

# Unique Bash version check
if ((BASH_VERSINFO[0] < 4))
then 
  echo "sensible.bash: Looks like you're running an older version of Bash." 
  echo "sensible.bash: You need at least bash-4.0 or some options will not work correctly." 
  echo "sensible.bash: Keep your software up-to-date!"
fi

## GENERAL OPTIONS ##

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

## SANE HISTORY DEFAULTS ##

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Huge history. Doesn't appear to slow things down, so why not?
HISTSIZE=500000
HISTFILESIZE=500000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
#bind '"\e[A": history-search-backward'
#bind '"\e[B": history-search-forward'
#bind '"\e[C": forward-char'
#bind '"\e[D": backward-char'

## BETTER DIRECTORY NAVIGATION ##

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null
# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null
# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

# This defines where cd looks for targets
# Add the directories you want to have fast access to, separated by colon
# Ex: CDPATH=".:~:~/projects" will look for targets in the current working directory, in home and in the ~/projects folder
CDPATH="."

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases
[[ -f ~/.autojump.bash ]] && source ~/.autojump.bash
[[ -f ~/.fzf-bindings.bash ]] && source ~/.fzf-bindings.bash
[[ -f ~/.fzf-completion.bash ]] && source ~/.fzf-completion.bash

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/sam/.local/bin/google-cloud-sdk/path.bash.inc' ]; then . '/home/sam/.local/bin/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/sam/.local/bin/google-cloud-sdk/completion.bash.inc' ]; then . '/home/sam/.local/bin/google-cloud-sdk/completion.bash.inc'; fi

[ -f /etc/bash_completion ] && source /etc/bash_completion
source <(kubectl completion bash)
eval "$(starship init bash)"

export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
