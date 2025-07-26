.PHONY: clean
clean:
	@bash ./scripts/symlinks.sh clean

.PHONY: ruby
ruby:
	@bash ./scripts/ruby.sh

.PHONY: links
links:
	@bash ./scripts/symlinks.sh

.PHONY: node
node:
	@bash ./scripts/node.sh

# https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating
.PHONY: nvm
nvm:
	@curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

.PHONY: pipx
pipx:
	@bash ./scripts/pipx.sh

.PHONY: ruby
ruby:
	@bash ./scripts/ruby.sh
