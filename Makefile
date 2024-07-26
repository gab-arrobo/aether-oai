#### Variables ####

export ROOT_DIR ?= $(PWD)
export OAI_ROOT_DIR ?= $(ROOT_DIR)

export ANSIBLE_NAME ?= ansible-oai
export HOSTS_INI_FILE ?= hosts.ini

export EXTRA_VARS ?= ""

#### Start Ansible docker ####

oai-ansible:
	export ANSIBLE_NAME=$(ANSIBLE_NAME); \
	sh $(OAI_ROOT_DIR)/scripts/ansible ssh-agent bash

#### a. Debugging ####
oai-pingall:
	ansible-playbook -i $(HOSTS_INI_FILE) $(OAI_ROOT_DIR)/pingall.yml \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)

#### b. Provision docker ####
oai-docker-install:
	ansible-playbook -i $(HOSTS_INI_FILE) $(OAI_ROOT_DIR)/docker.yml --tags install \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)
oai-docker-uninstall:
	ansible-playbook -i $(HOSTS_INI_FILE) $(OAI_ROOT_DIR)/docker.yml --tags uninstall \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)

oai-router-install:
	ansible-playbook -i $(HOSTS_INI_FILE) $(OAI_ROOT_DIR)/router.yml --tags install \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)
oai-router-uninstall:
	ansible-playbook -i $(HOSTS_INI_FILE) $(OAI_ROOT_DIR)/router.yml --tags uninstall \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)

oai-gNb-start:
	ansible-playbook -i $(HOSTS_INI_FILE) $(OAI_ROOT_DIR)/gNb.yml --tags start \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)
oai-gNb-stop:
	ansible-playbook -i $(HOSTS_INI_FILE) $(OAI_ROOT_DIR)/gNb.yml --tags stop \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)

oai-uEsim-start:
	ansible-playbook -i $(HOSTS_INI_FILE) $(OAI_ROOT_DIR)/uEsimulator.yml --tags start \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)
oai-uEsim-stop:
	ansible-playbook -i $(HOSTS_INI_FILE) $(OAI_ROOT_DIR)/uEsimulator.yml --tags stop \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)

# run oai-docker-install before running setup
oai-gNb-install: oai-docker-install oai-router-install oai-gNb-start
oai-gNb-uninstall:  oai-gNb-stop oai-router-uninstall

