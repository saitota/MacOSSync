#global env
.DEFAULT_GOAL := help
WORK_PATH   := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))/
DOT_PATH    := $(WORK_PATH)/dotfiles
DOTFILES    := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

help: ##print this message
	@echo "MacOS setup automation makefile"
	@echo "Usage: make SUB_COMMAND ( brew/chrome/terraform etc.. )"
	@printf "\033[36m%-30s\033[0m %-50s %s\n" "[Sub command]" "[Description]"
	@grep -E '^[/a-zA-Z_-]+:.*?##.*$$' $(MAKEFILE_LIST) \
		| awk '{sub(":.*##", ": ##", $$0);print $$0}' \
		| awk -F " *?##*?" '{printf "\033[36m%-30s\033[0m %-50s %s\n", $$1, $$2, $$3}'

setup: brew bundle upgrade fonts symlinks ##install brew/cask-brew/fonts and set symlink to dotfiles

fonts: ##install some fonts
	@ls ~/Library/Fonts/Cascadia.ttf || curl -L https://github.com/microsoft/cascadia-code/releases/download/v1909.16/Cascadia.ttf > ~/Library/Fonts/Cascadia.ttf
	@ls ~/Library/Fonts/Source\ Code\ Pro\ for\ Powerline.otf || curl -L https://github.com/powerline/fonts/raw/master/SourceCodePro/Source%20Code%20Pro%20for%20Powerline.otf > ~/Library/Fonts/Source\ Code\ Pro\ for\ Powerline.otf
	#@ls ~/Library/Fonts/SFMonoSquare-Regular.otf || brew tap delphinus/sfmono-square && brew install sfmono-square && cp /usr/local/opt/sfmono-square/share/fonts/SFMonoSquare-* ~/Library/Fonts/
	#@ls ~/Library/Fonts/Hack*.ttf || brew tap homebrew/cask-fonts && brew install --cask font-hack-nerd-font

brew: ##install brew
	which brew || (curl -fsSL "https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh" --output /var/tmp/install.sh && /bin/bash /var/tmp/install.sh && echo 'eval "$$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile && eval "$$(/opt/homebrew/bin/brew shellenv)" )

upgrade: ##update & upgrade brew
	@brew update; brew upgrade;

bundle: ##install brew bundle, see ./Brewfile
	brew bundle

symlinks: ##set symlinks to dotfiles
	#hyper
	@ls ~/.hyper.js || ln -s $$(pwd)/dotfiles/.hyper.js ~/.hyper.js
	#terminus
	#@ls ~/Library/Application\ Support/terminus/ || mkdir ~/Library/Application\ Support/terminus/
	#@ls ~/Library/Application\ Support/terminus/config.yaml || ln -s $$(pwd)/dotfiles/Library/Application\ Support/terminus/config.yaml ~/Library/Application\ Support/terminus/config.yaml
	#fish
	#@ls ~/.config/fish/ || mkdir ~/.config/fish/
	#@ls ~/.config/fish/config.fish || ln -s $$(pwd)/dotfiles/.config/fish/config.fish ~/.config/fish/config.fish
	#zsh
	@ls ~/.zshrc || ln -s $$(pwd)/dotfiles/.zshrc ~/.zshrc
	#starship
	@ls ~/.config/starship.toml || mkdir ~/.config/ || ln -s $$(pwd)/dotfiles/.config/starship.toml ~/.config/starship.toml
	#vim
	@ls ~/.vim || ln -s $$(pwd)/dotfiles/.vim/ ~/.vim
	@ls ~/.vimrc || ln -s $$(pwd)/dotfiles/.vimrc ~/.vimrc
	#nvim
	#@ls ~/.config/nvim/ || ln -s $$(pwd)/dotfiles/.config/nvim/ ~/.config/nvim
	#vscode
	#@ls ~/Library/Application\ Support/Code/User || ln -s $$(pwd)/dotfiles/vscode/User ~/Library/Application\ Support/Code/User
	#@ls ~/.vscode/extensions || ln -s $$(pwd)/dotfiles/vscode/extensions ~/.vscode/extensions

unlinks:
	unlink ~/.hyper.js || true
	unlink ~/Library/Application\ Support/terminus/config.yaml || true
	unlink ~/.config/fish/config.fish || true
	unlink ~/.zshrc || true
	unlink ~/.config/starship.toml || true
	unlink ~/.vim || true
	unlink ~/.vimrc || true
	unlink ~/.config/nvim || true

dump:
	mv ./Brewfile ./Brewfile_bk
	brew bundle dump
