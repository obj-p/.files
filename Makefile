LINKS := nvim
OS    := $(shell uname -s)

ifeq ($(OS), Darwin)
	include darwin/Darwin.mk
endif

.PHONY: clean
clean:
	@bash ./scripts/symlinks.sh clean

.PHONY: links
links:
	@bash ./scripts/symlinks.sh

.PHONY: pipx
pipx:
	@bash ./scripts/pipx.sh
