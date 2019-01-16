[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
xrandr --dpi 220
xrdb -merge ~/.Xresources
exec i3
