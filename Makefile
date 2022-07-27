.PHONY: init
init:
	git submodule update --init --recursive --remote
	ln -fs ~/.dotfiles/dunst/ ~/.config/
	ln -fs ~/.dotfiles/compton/ ~/.config/
	ln -fs ~/.dotfiles/fish/ ~/.config/
	ln -fs ~/.dotfiles/i3/ ~/.config/
	ln -fs ~/.dotfiles/kitty/ ~/.config/
	ln -fs ~/.dotfiles/nvim/ ~/.config/
	ln -fs ~/.dotfiles/.gitconfig ~/
