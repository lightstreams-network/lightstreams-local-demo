DEP_REPO = github.com/golang/dep/cmd/dep
DEP_BIN_PATH := $(shell command -v dep 2> /dev/null)

BUILD_TAGS? := lightchain
BUILD_DEBUG_FLAGS = -gcflags=all="-N -l"

define VERSION_TAG
	$(shell git ls-remote git@github.com:lightstreams-network/lightchain.git HEAD | cut -f1 | cut -c1-9)
endef

.PHONY: help
help: ## Prints this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: all
all: get_vendor_deps install ## Downloads dependencies and install lightchain

.PHONY: check-tools
check-tools: ## Check that required tools are installed
ifdef DEP_BIN_PATH
	@echo "DEP is correctly installed"
else
	@echo "Not DEP found. Visit http://${DEP_REPO} and follow installation instructions."
endif

.PHONY: install
install: ## Install lightchain
	go install ./cmd/lightchain

.PHONY: build
build: ## Build lightchain
	go build -o ./build/lightchain ./cmd/lightchain

.PHONY: clean
clean: ## Clean binaries
	@rm build/lightchain

.PHONY: build-dev
build-dev: ## (Dev) Build lightchain
	CGO_ENABLED=1 go build $(BUILD_DEBUG_FLAGS) -o ./build/lightchain ./cmd/lightchain

.PHONY: gen-bindings
gen-bindings: ## (Dev) Generate bindings
	abigen --sol ./distribution/distribution.sol --pkg distribution --out ./distribution/distribution_bindings.go

.PHONY: get_vendor_deps
get_vendor_deps: check-tools ## Download dependencies
	@rm -rf vendor
	@echo "--> dep ensure"
	@dep ensure

.PHONY: docker
docker: ## Build docker image for lightchain
	@echo "Build docker image"
	go build -o ./build/lightchain ./cmd/lightchain
	docker build --no-cache -t lightchain:latest -f ./Dockerfile .

.PHONY: docker-dev
docker-dev: ## Build docker image for lightchain
	@echo "Build docker image"
	docker build -t lightchain:latest-dev -f ./Dockerfile.dev --build-arg version="$(VERSION_TAG)"  .

#!/bin/bash

K8_PATH = ./k8

create-validators:
	@echo "Creating Validators"
	@mkdir -p deploy/node1/init
	@mkdir -p deploy/node2/init
	@mkdir -p deploy/node3/init
	@mkdir -p deploy/node4/init

	cd $(K8_PATH) && \
		kubectl apply -f service-validators.yml ; \
		kubectl apply -f deploy-validators.yml ; \

delete-validators:
	@echo "Deleting Validators"

	@rm -rf deploy/node1/init
	@rm -rf deploy/node2/init
	@rm -rf deploy/node3/init
	@rm -rf deploy/node4/init

	kubectl delete deployment validator-node1
	kubectl delete deployment validator-node2
	kubectl delete deployment validator-node3
	kubectl delete deployment validator-node4

	kubectl delete service validator-node1
	kubectl delete service validator-node2
	kubectl delete service validator-node3
	kubectl delete service validator-node4

	kubectl delete service validator-eth1
	kubectl delete service validator-eth2
	kubectl delete service validator-eth3
	kubectl delete service validator-eth4

	kubectl delete service validator-tmt1
	kubectl delete service validator-tmt2
	kubectl delete service validator-tmt3
	kubectl delete service validator-tmt4

create-agent1:
	@echo "Creating Agent 1"
	cd $(K8_PATH) && \
		kubectl apply -f service-agent1.yml ; \
		kubectl apply -f agent-node1.yml ; \

delete-agent1:
	@echo "Deleting Agent 1"

	kubectl delete pod agent-node1
	kubectl delete service agent-node1
	kubectl delete service agent-node1-ipfs

create-agent2:
	@echo "Creating Agent 2"
	cd $(K8_PATH) && \
		kubectl apply -f service-agent2.yml ; \
		kubectl apply -f agent-node2.yml ; \

delete-agent2:
	@echo "Deleting Agent 2"

	kubectl delete pod agent-node2
	kubectl delete service agent-node2
	kubectl delete service agent-node2-ipfs

create-agent3:
	@echo "Creating Agent 3"
	cd $(K8_PATH) && \
		kubectl apply -f service-agent3.yml ; \
		kubectl apply -f agent-node3.yml ; \

delete-agent3:
	@echo "Deleting Agent 3"

	kubectl delete pod agent-node3
	kubectl delete service agent-node3
	kubectl delete service agent-node3-ipfs

create-agent4:
	@echo "Creating Agent 4"
	cd $(K8_PATH) && \
		kubectl apply -f service-agent4.yml ; \
		kubectl apply -f agent-node4.yml ; \

delete-agent4:
	@echo "Deleting Agent 4"

	kubectl delete pod agent-node4
	kubectl delete service agent-node4
	kubectl delete service agent-node4-ipfs

	

