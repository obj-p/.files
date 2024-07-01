.PHONY: brew
brew:
	brew bundle --no-lock

.PHONY: emacs
emacs:
	brew tap railwaycat/emacsmacport
	brew install emacs-mac --with-native-comp
cp -a $(shell brew --prefix)/emacs-mac/Emacs.app /Applications:
