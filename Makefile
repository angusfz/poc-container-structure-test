SHELL=/usr/bin/env bash -e -o pipefail

printPhaseName = echo "$(shell tput bold;tput setaf 2 ) === $@ === $(shell tput sgr0)"

.PHONY: install_tools
install_tools:
	@$(call printPhaseName)
	brew install container-structure-test

.PHONY: build_images
build_images:
	@$(call printPhaseName)
	docker-compose build nginx-all200

.PHONY: clean
clean:
	docker rmi nginx-all200

.PHONY: test
test: build_images
	@$(call printPhaseName)
	container-structure-test test --image nginx-all200 --config nginx-all200.config.yaml