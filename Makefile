all:

vim:
	pacman -S gvim --noconfirm
	cp .vimrc /home/sam/
	curl -fLo /home/sam/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	mkdir /home/sam/.vim/undodir/
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
	sudo -H -u sam bash -c 'git config --global core.excludesfile /home/sam/.gitignore_global'
	sudo -H -u sam bash -c 'git config --global user.name "Sam Holmes"'
	sudo -H -u sam bash -c 'git config --global user.email samholmesdev@gmail.com'
	pacman -S ripgrep xclip fzf neofetch autojump docker docker-compose ranger tig ctags rofi --noconfirm
	pacman -S aurman --noconfirm
	sudo -H -u sam bash -c 'aurman -S polybar --noconfirm'
x:
	cp .xinitrc /home/sam/
	chown sam:sam /home/sam/.xinitrc
window-manager:
	pacman -S i3-gaps --noconfirm --ignore cronie
	rm /home/sam/.config/i3/config
	cp i3/config /home/sam/.config/i3/config
urxvt:
	cp .Xresources /home/sam/
	xrdb /home/sam/.Xresources
	chown sam:sam /home/sam/.Xresources
	pacman -S rxvt-unicode --noconfirm
keyboard:
	cp .Xmodmap /home/sam/.Xmodmap
	cp mac-keyboard.sh /usr/local/bin
	cp thinkpad-keyboard.sh /usr/local/bin
	cp pok3r-keyboard.sh /usr/local/bin
	cp kbdmap /usr/share/X11/xkb/symbols/us
	@echo 'xkb symbols need a reboot to fully take effect'
ssh:
	sudo -H -u sam bash -c 'ssh-keygen'
	sudo -H -u sam bash -c 'cat ~/.ssh/id_rsa.pub'
apps:
	pacman -S aurman --noconfirm
	sudo -H -u sam bash -c 'aurman -S google-chrome discord slack-desktop --noconfirm'
