all:

vim:
	pacman -S gvim --noconfirm
	cp .vimrc /home/sam/
	curl -fLo /home/sam/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	chown sam:sam /home/sam/.vimrc
	chown -R sam:sam /home/sam/.vim/
bash:
	rm /home/sam/.bash*
	cp .bash_profile /home/sam/
	cp .bashrc /home/sam/
	cp .bash_aliases /home/sam/
	cp .inputrc /home/sam/
	cp .gitignore_global /home/sam
	chown sam:sam /home/sam/.gitignore_global
	chown sam:sam /home/sam/.inputrc
	chown sam:sam /home/sam/.bash_profile
	chown sam:sam /home/sam/.bashrc
	chown sam:sam /home/sam/.bash_aliases
	pacman -S ripgrep xclip fzf neofetch autojump docker docker-compose ranger tig --noconfirm
x:
	cp .xinitrc /home/sam/
	chown sam:sam /home/sam/.xinitrc
i3:
	pacman -S i3-gaps --noconfirm
	rm /home/sam/.config/i3/config
	cp i3/config /home/sam/.config/i3/config

urxvt:
	cp .Xresources /home/sam/
	xrdb /home/sam/.Xresources
	chown sam:sam /home/sam/.Xresources
	pacman -S rxvt-unicode --noconfirm
keyboard:
	cp mac-keyboard.sh /usr/local/bin
	cp pc-keyboard.sh /usr/local/bin
