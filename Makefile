all: vim bash x window-manager urxvt keyboard ssh apps power-management development bluetooth
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
	sudo -H -u sam bash -c 'aurman -S ttf-spacemono cava --noconfirm'
x:
	cp .xinitrc /home/sam/
	chown sam:sam /home/sam/.xinitrc
window-manager:
	pacman -S i3-gaps
	sudo -H -u sam bash -c 'aurman -S perl-anyevent-i3 --noconfirm'
	rm /home/sam/.config/i3/config
	cp i3/config /home/sam/.config/i3/config
	cp i3/workspace-1.json /home/sam/.config/i3/workspace-1.json
urxvt:
	cp .Xresources /home/sam/
	xrdb /home/sam/.Xresources
	chown sam:sam /home/sam/.Xresources
	pacman -S python-pywal rxvt-unicode --noconfirm
keyboard:
	cp .Xmodmap /home/sam/.Xmodmap
	cp mac-keyboard.sh /usr/local/bin
	cp thinkpad-keyboard.sh /usr/local/bin
	cp kbdmap /usr/share/X11/xkb/symbols/us
	@echo 'xkb symbols need a reboot to fully take effect'
ssh:
	sudo -H -u sam bash -c 'ssh-keygen'
	sudo -H -u sam bash -c 'cat ~/.ssh/id_rsa.pub'
apps:
	pacman -S hicolor-icon-theme chromium aurman --noconfirm
	sudo -H -u sam bash -c 'aurman -S discord slack-desktop --noconfirm'
chromium:
	cp scripts/github.sh /usr/local/bin
	cp scripts/hn.sh /usr/local/bin
	cp scripts/jira.sh /usr/local/bin
	cp scripts/messenger.sh /usr/local/bin
	cp scripts/reddit.sh /usr/local/bin
	cp scripts/youtube.sh /usr/local/bin
power-management:
	pacman -S powertop tlp --noconfirm
	systemctl enable tlp.service
	systemctl enable tlp-sleep.service
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
