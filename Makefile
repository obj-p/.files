LINKS := emacs nvim
OS    := $(shell uname -s)

ifeq ($(OS), Darwin)
	include darwin/Darwin.mk
endif

.PHONY: clean
clean:
	@$(foreach link,$(LINKS),rm ~/.config/$(link);)

.PHONY: links
links:
	@$(foreach link,$(LINKS),ln -nsf $(abspath ./$(link)) ~/.config/$(link);)
