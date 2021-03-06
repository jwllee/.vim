# Note that this is basically a copy from https://github.com/jessfraz/.vim/blob/master/Makefile

XDG_CONFIG_HOME := $(HOME)/.config

.PHONY: install
install: ## Sets up symlink for user and root .vimrc for vim and neovim
	cat "$(HOME)/.vim/lib/elixir-ctags/.ctags" >> "$(HOME)/.ctags"
	ln -snf "$(HOME)/.vim/vimrc" "$(HOME)/.vimrc"
	sudo ln -snf "$(HOME)/.vim" /root/.vim
	sudo ln -snf "$(HOME)/.vimrc" /root/.vimrc
	mkdir -p "$(XDG_CONFIG_HOME)"
	echo "set runtimepath^=~/.vim runtimepath+=~/.vim/after" > "$(XDG_CONFIG_HOME)/nvim/init.vim"
	echo "let &packpath = &runtimepath" >> "$(XDG_CONFIG_HOME)/nvim/init.vim"
	echo "source ~/.vimrc" >> "$(XDG_CONFIG_HOME)/nvim/init.vim"

.PHONY: update
update: update-pathogen update-plugins ## Updates pathogen and all plugins.

.PHONY: update-plugins
update-plugins: ## Updates all plugins.
	git submodule update --init --recursive

.PHONY: update-pathogen
update-pathogen: ## Updates pathogen.
	curl -LSso $(CURDIR)/autoload/pathogen.vim https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

.PHONY: README.md
README.md: ## Generates and updates plugin info in README.md.
	@sed -i '/Dockerfile/q' $@
	@git submodule --quiet foreach bash -c "echo -e \"* [\$$(git config --get remote.origin.url | sed 's#https://##' | sed 's#git://##' | sed 's/.git//')](\$$(git config --get remote.origin.url))\"" >> $@

check_defined = \
				$(strip $(foreach 1,$1, \
				$(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
				  $(if $(value $1),, \
				  $(error Undefined $1$(if $2, ($2))$(if $(value @), \
				  required by target `$@')))

.PHONY: remove-submodule
remove-submodule: ## Removes a git submodule (ex MODULE=bundle/nginx.vim).
	@:$(call check_defined, MODULE, path of module to remove)
	mv $(MODULE) $(MODULE).tmp
	git submodule deinit -f -- $(MODULE)
	$(RM) -r .git/modules/$(MODULE)
	git rm -f $(MODULE)
	$(RM) -r $(MODULE).tmp


.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

