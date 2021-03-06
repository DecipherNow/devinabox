SHELL := /bin/bash

.PHONY: all
all: setup verify-terraform-version
	./apply.sh

.PHONY: setup
setup: config
	packer build packer.json
	@rm -f .credentials > /dev/null 2>&1

.PHONY: config
config:
	@./config.sh

.PHONY: destroy
destroy: verify-terraform-version
	@./destroy.sh

.PHONY: apply
apply: verify-terraform-version
	@./apply.sh

.PHONY: list
list: 
	@./list.sh

.PHONY: packer
packer:
	packer build packer.json
	@rm -f .credentials > /dev/null 2>&1

.PHONY: init
init:
	@echo -e "\n ==> Initializing Terrraform..."
	@cd terraform && terraform init

.PHONY: verify-terraform-version
verify-terraform-version: init
	@echo -e "\n ==> Checking Terraform version...\n"
	$(eval TFCHECK=$(shell cd terraform; terraform plan --var deploy_name="version_check" -target=terraform.required_version > /dev/null 2>&1; echo $$?))
	@if [ ${TFCHECK} -ne 0 ]; then \
		echo "Error: Your terraform version is not valid for this configuration."; \
		exit 2 ; \
	fi