set fish_greeting ""

set -gx TERM xterm-256color

# Theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# Python/C/M1 build flags
set -gx LDFLAGS "-L/opt/homebrew/opt/openssl@1.1/lib -L/opt/homebrew/opt/libpq/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/openssl@1.1/include -I/opt/homebrew/opt/libpq/include"
set -gx CFLAGS "-I/opt/homebrew/opt/openssl@1.1/include -I/opt/homebrew/opt/libpq/include"
set -gx LANG en_US.UTF-8
set -gx COOKIECUTTER_CONFIG /Users/samholmes/.config/cookiecutter.yaml

# aliases
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias ag "rg -i --hidden"
alias gs "git status"
alias gd "git diff"
alias gc "git checkout"
alias gb "git branch | cut -c 3- | fzf | xargs git checkout"
alias gu "git push --set-upstream origin (git rev-parse --abbrev-ref HEAD)"
alias gp "git push"
alias gl "git pull"
alias ga "git add"
alias gh "git rev-parse HEAD"
alias sg "git rev-parse --short=10 HEAD"
alias cc "xclip -selection clipboard"
alias k "kubectl"
alias o "xdg-open"
alias search "rg -i --hidden -A 5 -B 5"
alias proxy_cust_prod "cloud_sql_proxy -instances=platform-v2-project:europe-west1:customer-data=tcp:5432 --enable_iam_login"
alias proxy_cust_dev "cloud_sql_proxy -instances=platform-v2-project:europe-west1:customers-data-dev=tcp:5432 --enable_iam_login"
alias proxy_ops_prod "cloud_sql_proxy -instances=platform-v2-project:europe-west1:operations-data=tcp:5432 --enable_iam_login"
alias proxy_ops_dev "cloud_sql_proxy -instances=platform-v2-project:europe-west1:operations-data-dev=tcp:5432 --enable_iam_login"

command -qv nvim && alias vim nvim

set -gx EDITOR nvim
set -gx VISUAL nvim

set -gx PATH /opt/homebrew/bin $PATH
set -gx PATH /opt/homebrew/Caskroom $PATH
set -gx PATH ~/.local/bin $PATH
set -gx USE_GKE_GCLOUD_AUTH_PLUGIN True
 [ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish
