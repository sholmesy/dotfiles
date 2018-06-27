[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
xrandr --dpi 196
xrdb -merge ~/.Xresources
exec i3

