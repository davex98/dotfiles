.PHONY: init
init:
	ln -fs ~/.dotfiles/yabai/ ~/.config/
	ln -fs ~/.dotfiles/skhd/ ~/.config/
	ln -fs ~/.dotfiles/fish/ ~/.config/
	ln -fs ~/.dotfiles/nvim/ ~/.config/
	ln -fs ~/.dotfiles/tmux/.tmux.conf ~/
	ln -fs ~/.dotfiles/.gitconfig ~/
