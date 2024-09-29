OS := $(shell uname -s)

ifeq ($(OS), Darwin)
	include darwin/Darwin.mk
endif
