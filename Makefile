all: vim bash x window-manager urxvt keyboard apps development bluetooth
vim:
	pacman -S gvim --noconfirm
	cp .vimrc /home/sam/
	curl -fLo /home/sam/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	mkdir -p /home/sam/.vim/undodir/
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
	pacman -S ripgrep xclip fzf neofetch autojump ranger tig ctags rofi feh --noconfirm
	pacman -S aurman --noconfirm
	sudo -H -u sam bash -c 'aurman -S ttf-spacemono cava pick --noconfirm'
x:
	cp .xinitrc /home/sam/
	chown sam:sam /home/sam/.xinitrc
window-manager:
	pacman -S i3-gaps
	sudo -H -u sam bash -c 'aurman -S perl-anyevent-i3 polybar-git --noconfirm'
	rm /home/sam/.config/i3/config
	cp i3/config /home/sam/.config/i3/config
	cp .polybar /home/sam/.config/polybar/config
	cp scripts/start-poly.sh /home/sam/.config/polybar/launch.sh
urxvt:
	cp .Xresources /home/sam/
	xrdb /home/sam/.Xresources
	chown sam:sam /home/sam/.Xresources
	pacman -S python-pywal rxvt-unicode --noconfirm
	wal -i orange-colors.jpg
keyboard:
	cp .Xmodmap /home/sam/.Xmodmap
	cp scripts/mac-keyboard.sh /usr/local/bin
	cp scripts/thinkpad-keyboard.sh /usr/local/bin
	cp scripts/anne-pro.sh /usr/local/bin
	cp kbdmap /usr/share/X11/xkb/symbols/us
	@echo 'xkb symbols need a reboot to fully take effect'
apps:
	pacman -R kalu
	pacman -S hicolor-icon-theme opera opera-ffmpeg-codes aurman --noconfirm
	sudo -H -u sam bash -c 'aurman -S discord slack-desktop --noconfirm'
development:
	pacman -S python-setuptools python-pip python-virtualenv docker docker-compose aws-cli go go-tools npm
	sudo -H -u sam bash -c 'aurman -S pgcli --noconfirm'
bluetooth:
	pacman -Syu  pulseaudio-alsa pulseaudio-bluetooth bluez bluez-libs bluez-utils
	rfkill block all
	btmgmt ssp of
	gpasswd -a sam lp
	rfkill unblock all
.PHONY: all
