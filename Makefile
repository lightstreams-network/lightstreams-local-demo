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

	

