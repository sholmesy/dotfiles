# Vim
fish_vi_key_bindings
function vim --wraps=vim; nvim $argv; end

# Theme
set fish_greeting ""
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always
set -gx STARSHIP_CONFIG ~/.config/starship/starship.toml

# Navigation
function ag --wraps=rg; rg -i --hidden $argv; end
function cc --wraps=xclip; xclip -selection clipboard; end
function ls --wraps=eza; eza --icons $argv; end
function cat --wraps=batcat; batcat $argv; end
function fd --wraps fdfind; fdfind -H --color never $argv; end

# Git
function gs --wraps=git; git status $argv; end
function gd --wraps=git; git diff $argv; end
function gc --wraps=git; git checkout $argv; end
function gu --wraps=git; git push --set-upstream origin (git rev-parse --abbrev-ref HEAD) $argv; end
function gp --wraps=git; git push $argv; end
function gl --wraps=git; git pull $argv; end
function ga --wraps=git; git add $argv; end
function gh; git rev-parse HEAD; end
function gb; git branch | cut -c 3- | fzf | xargs git checkout; end
function sg; git rev-parse --short=10 HEAD; end

# Environment
set -gx EDITOR ~/.local/bin/nvim
set -gx VISUAL ~/.local/bin/nvim
set -gx PATH ~/.local/bin $PATH
set -gx PATH ~/.local/share $PATH
set -gx PATH ~/.local/share/nvm/v22.2.0/bin $PATH
set -gx PATH ~/.local/go/bin $PATH
set -gx XDG_CONFIG_HOME ~/.config
set -gx XDG_DATA_HOME ~/.local/share
set -gx XDG_CACHE_HOME ~/.local/cache
set -gx XDG_STATE_HOME ~/.local/state
set -gx STARSHIP_CACHE ~/.local/cache/starship
set -gx NVM_DIR ~/.config/nvm


# Source files
starship init fish | source
if test -f /usr/share/autojump/autojump.fish; 
    source /usr/share/autojump/autojump.fish; 
end;
if test -f $NVM_DIR/nvm.sh;
    source $NVM_DIR/nvm.sh;
end;
