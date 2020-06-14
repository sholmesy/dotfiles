# You need:
# sudo apt install git
# sudo apt install make
# git clone https://github.com/sholmesy/dotfiles.git

git:
	git config --global core.excludesfile '.gitignore'
	git config --global user.email "samholmesdev@gmail.com"
	git config --global user.name "Sam Holmes"
	ssh-keygen
	cat ~/.ssh/id_rsa.pub | cc

utils:
	sudo apt install ripgrep feh exuberant-ctags apt-transport-https curl build-essential python python3 fzf autojump tig acpi
	wget https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.bash
	wget https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.bash
	mv ~/key-bindings.bash .fzf-bindings.bash
	mv ~/completion.bash .fzf-completion.bash
	cp /usr/share/autojump/autojump.bash .autojump.bash

i3:
	sudo apt install i3xrocks-memory i3xrocks-battery regolith-look-lascaille i3status
	mkdir -p ~/.config/regolith/i3
	cp ~/dotfiles/i3 ~/.config/regolith/i3/config
	cp ~/dotfiles/Xresources ~/.config/regolith/Xresources
	xrdb ~/.config/regolith/Xresources
	i3-msg reload
	regolith-look refresh
	@echo "Need to logout for all regolith/i3 changes to take affect"
	sudo cp ~/dotfiles/colors /etc/regolith/styles/lascaille/color 

vim: utils
	sudo apt install neovim
	sudo apt remove vim
	mkdir -p ~/.config/nvim
	cp ~/dotfiles/vim ~/.config/nvim/init.vim
	sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

browser: utils
	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	sudo apt update
	sudo apt install brave-browser

inputs:
	sudo cp ~/dotfiles/kbdmap /usr/share/X11/xkb/symbols/us
	mkdir -p ~/.local/bin
	cp ~/dotfiles/keyboard ~/.local/bin/keyboard
	cp ~/dotfiles/make-caps-iso ~/.local/bin/make-caps-iso
	cp ~/dotfiles/make-right-alt-control ~/.local/bin/make-right-alt-control
	cp ~/dotfiles/input ~/.inputrc
	@echo "Need to logout for keyboard changes to take affect"

gnome:
	gsettings set org.gnome.desktop.interface enable-animations false

bash:
	cp ~/dotfiles/alias ~/.aliases
	cp ~/dotfiles/bashrc ~/.bashrc
	cp ~/dotfiles/bash_profile ~/.bash_profile

cleanup:
	sudo apt autoremove

all:
	make utils
	make i3
	make vim
	make browser
	make inputs
	make gnome
	make bash
	make cleanup
