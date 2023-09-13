SPM_CLI_COMMON_PATH := Tools/Common/.build/release

TEXT_RED=\033[0;31m
TEXT_NO_COLOR=\033[0m

.PHONY: help
help: ## Show this usage
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: bootstrap
bootstrap: ## bootsrap
	echo "${TEXT_RED}run 'make setup-precommit-tool' before committing.${TEXT_NO_COLOR}"
	make install-xcode-template
	make build-spm-cli-tools
	${SPM_CLI_COMMON_PATH}/mint bootstrap

.PHONY: build spm cli tools
build-spm-cli-tools: ## build Swift Package Manager cli tools
	swift build -c release --package-path ./Tools/Common --product mint

.PHONY: clean cli tools
clean-spm-cli-tools: ## clean Swift Package Manager cli tools cache
	swift package --package-path ./Tools/Common clean

.PHONY: install xcode template
install-xcode-template: ## install preconfigured xcode templates
	sh scripts/xcode/install-xcode-template.sh

# Node
.PHONY: setup-node
setup-node: ## setup node version management environment
	cat scripts/lint-setup/zshrc_cp.txt >> ~/.zshrc
	source ~/.zshrc
	brew install nodenv
	nodenv install 18.1.0
	nodenv local 18.1.0
	
.PHONY: setup-precommit-tool
setup-precommit-tool: ## setup tools for linting at pre-commit
	echo "${TEXT_RED}run 'make setup-node' if the specified version of node is not installed.${TEXT_NO_COLOR}"
	npm install yarn -d
	npx yarn add husky lint-staged @commitlint/config-conventional @commitlint/cli -d
	npx yarn install
	npx yarn husky install
	sh scripts/lint-setup/huskyrc.sh
	npx husky add .husky/commit-msg "npx yarn commitlint -e"
	npx husky add .husky/pre-commit "npx yarn lint-staged"

.PHONY: remove-precommit-tool
remove-precommit-tool: ## remove tools for linting at pre-commit
	npx yarn remove husky lint-staged @commitlint/config-conventional @commitlint/cli -d
	npm uninstall yarn -d
	npm list -d
	npm list -g
