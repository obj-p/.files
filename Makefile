.PHONY: clean
clean:
	@bash ./scripts/symlinks.sh clean

.PHONY: claude-commands
claude-commands:
	@mkdir -p ~/.claude/commands
	@cp claude/commands/* ~/.claude/commands

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
