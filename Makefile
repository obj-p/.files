.PHONY: clean
clean:
	@bash ./scripts/symlinks.sh clean

.PHONY: claude
claude:
	@bash ./scripts/claude.sh

.PHONY: go
go:
	@bash ./scripts/go.sh

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
