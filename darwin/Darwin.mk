.PHONY: make-zsh-completion
make-zsh-completion:
	@echo "zstyle ':completion:*:make:*:targets' call-command true" >> ~/.zshrc
	@echo "zstyle ':completion:*:*:make:*' tag-order 'targets'" >> ~/.zshrc
