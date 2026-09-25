# Linked by scripts/symlinks.sh to the Brewfile for this machine's profile.
BREWFILE := $(HOME)/Brewfile

# File-wide: the install steps depend on each other (brew needs the linked
# Brewfile, everything after needs brew's packages) and nothing else here
# benefits from -j. Apple's make 3.81 ignores the per-target form.
.NOTPARALLEL:

.PHONY: help
help: ## Show this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@bash scripts/help.sh $(MAKEFILE_LIST)

.PHONY: bootstrap
bootstrap: ## Development setup
	@pre-commit install --hook-type pre-commit --hook-type pre-push

.PHONY: pre-commit
pre-commit: ## Run pre-commit
	@pre-commit run

.PHONY: brew
brew: ## Install Homebrew dependencies from the linked Brewfile
	@brew bundle --file="$(BREWFILE)"

.PHONY: brew-cleanup
brew-cleanup: ## Show packages missing from the Brewfile and prompt to uninstall them
	@brew bundle cleanup --file="$(BREWFILE)"

.PHONY: clean
clean: ## Remove symlinks
	@bash ./scripts/symlinks.sh clean

.PHONY: claude
claude: ## Configure Claude Code plugins
	@bash ./scripts/claude.sh

.PHONY: codex
codex: ## Install and configure Codex CLI
	@bash ./scripts/codex.sh

.PHONY: codex-config
codex-config: ## Disable anonymous Codex usage metrics and terminal animations
	@python3 ./scripts/codex-config.py

.PHONY: git-lfs
git-lfs: ## Initialize git-lfs hooks and filters
	@git lfs install --skip-repo

.PHONY: install
install: links brew tools git-lfs tpm claude bootstrap ## Full setup on a new machine, in order

.PHONY: links
links: ## Create symlinks
	@bash ./scripts/symlinks.sh

.PHONY: pipx
pipx: ## Install pipx packages
	@bash ./scripts/pipx.sh

.PHONY: tools
tools: ## Install mise tools
	@mise install

.PHONY: tpm
tpm: ## Install tmux plugins
	@bash ./scripts/tpm.sh
