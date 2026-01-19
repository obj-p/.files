PYTHON            ?= python3
PRE_COMMIT_VERSION = 4.2.0
BIN_PRE_COMMIT     = bin/pre-commit-$(PRE_COMMIT_VERSION).pyz
PRE_COMMIT         = $(PYTHON) $(BIN_PRE_COMMIT)

.PHONY: help
help: ## Show this help message
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@bash scripts/help.sh $(MAKEFILE_LIST)

$(BIN_PRE_COMMIT): ## Download pre-commit
	@curl --create-dirs --output-dir bin -LO \
		https://github.com/pre-commit/pre-commit/releases/download/v$(PRE_COMMIT_VERSION)/pre-commit-$(PRE_COMMIT_VERSION).pyz

.PHONY: bootstrap
bootstrap: ## Development setup
	@$(MAKE) $(BIN_PRE_COMMIT)
	@$(PRE_COMMIT) install --hook-type pre-commit --hook-type pre-push

.PHONY: pre-commit
pre-commit: ## Run pre-commit
	@$(PRE_COMMIT) run

.PHONY: clean
clean: ## Remove symlinks
	@bash ./scripts/symlinks.sh clean

.PHONY: claude
claude: ## Configure Claude Code plugins
	@bash ./scripts/claude.sh $(CURDIR)/claude

.PHONY: go
go: ## Install Go tools
	@bash ./scripts/go.sh

.PHONY: java
java: ## Install Java tools
	@bash ./scripts/java.sh

.PHONY: links
links: ## Create symlinks
	@bash ./scripts/symlinks.sh

.PHONY: node
node: ## Install Node tools
	@bash ./scripts/node.sh

.PHONY: pipx
pipx: ## Install pipx packages
	@bash ./scripts/pipx.sh

.PHONY: ruby
ruby: ## Install Ruby tools
	@bash ./scripts/ruby.sh
