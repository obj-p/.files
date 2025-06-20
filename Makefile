.PHONY: clean
clean:
	@bash ./scripts/symlinks.sh clean

.PHONY: ruby
ruby:
	@bash ./scripts/ruby.sh

.PHONY: links
links:
	@bash ./scripts/symlinks.sh

.PHONY: pipx
pipx:
	@bash ./scripts/pipx.sh
