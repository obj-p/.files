.PHONY: clean
clean:
	@bash ./scripts/symlinks.sh clean

.PHONY: claude
claude:
	@claude config add extraKnownMarketplaces.dotfiles-marketplace.source.source directory
	@claude config add extraKnownMarketplaces.dotfiles-marketplace.source.path $(CURDIR)/claude
	@claude config add enabledPlugins.dotfiles@dotfiles-marketplace true

.PHONY: go
go:
	@bash ./scripts/go.sh

.PHONY: java
java:
	@bash ./scripts/java.sh

.PHONY: links
links:
	@bash ./scripts/symlinks.sh

.PHONY: node
node:
	@bash ./scripts/node.sh

.PHONY: pipx
pipx:
	@bash ./scripts/pipx.sh

.PHONY: ruby
ruby:
	@bash ./scripts/ruby.sh
