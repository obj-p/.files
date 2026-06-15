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

.PHONY: clean
clean: ## Remove symlinks
	@bash ./scripts/symlinks.sh clean

.PHONY: claude
claude: ## Configure Claude Code plugins
	@bash ./scripts/claude.sh

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
