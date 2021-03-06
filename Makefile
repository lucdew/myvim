XDG_CONFIG_HOME ?= $(HOME)/.config

.PHONY: install
install: ## Sets up symlink for user and root .vimrc for vim and neovim.
	ln -snf "$(HOME)/.vim/vimrc" "$(HOME)/.vimrc"
	ln -snf "$(HOME)/.vim/vimrc" "$(HOME)/.gvimrc"
	mkdir -p "$(XDG_CONFIG_HOME)"
	ln -snf "$(HOME)/.vim" "$(XDG_CONFIG_HOME)/nvim"
	sudo ln -snf "$(HOME)/.vim" /root/.vim
	sudo ln -snf "$(HOME)/.vimrc" /root/.vimrc
	sudo mkdir -p /root/.config
	sudo ln -snf "$(HOME)/.vim" /root/.config/nvim

.PHONY: dev
dev:
	echo "let isDev=1" > "$(HOME)/.vim/env"

.PHONY: update
update: update-vim-plug update-plugins  ## Updates pathogen and all plugins.

.PHONY: update-plugins
update-plugins: ## Updates all plugins.
	vim +'PlugUpdate --sync' +qa

.PHONY: update-vim-plug
update-vim-plug: ## Updates vim-plug.
	curl -LSso $(CURDIR)/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

.PHONY: README.md
README.md: ## Generates and updates plugin info in README.md.
	@sed -i '/Plugins Used/q' $@
	@cat vimrc | grep -ozP "(?s)plugged'\)\K.*?(?=\ncall plug\#end)" | tr -d '\000'  | grep -E '^\s*Plug' | sed -E "s#\s*Plug '([^']+)'.*#* [github.com/\1](https://github.com/\1)#g" >> $@
	

check_defined = \
				$(strip $(foreach 1,$1, \
				$(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
				  $(if $(value $1),, \
				  $(error Undefined $1$(if $2, ($2))$(if $(value @), \
				  required by target `$@')))



.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
