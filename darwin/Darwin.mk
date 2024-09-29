CURRENT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
CASKS       := $(shell grep 'cask' $(CURRENT_DIR)/Brewfile | sed 's/cask "\(.*\)"/\1/')
FORMULA     := $(shell grep 'brew' $(CURRENT_DIR)/Brewfile | sed 's/brew "\(.*\)"/\1/')

.PHONY: brew
brew:
	brew bundle --no-lock

.PHONY: $(CASKS)
$(CASKS):
	brew install --cask $@

.PHONY: emacs
emacs:
	brew install fd findutils gcc libgccjit
	brew tap railwaycat/emacsmacport
	brew install emacs-mac --with-native-comp
	cp -a $(shell brew --prefix)/emacs-mac/Emacs.app /Applications

.PHONY: $(FORMULA)
$(FORMULA):
	brew install $@

.PHONY: make-zsh-completion
make-zsh-completion:
	@echo "zstyle ':completion:*:make:*:targets'" >> ~/.zshrc
	@echo "zstyle ':completion:*:make:*' tag-order targets" >> ~/.zshrc

.PHONY: pre-commit
pre-commit:
	pipx install pre-commit
