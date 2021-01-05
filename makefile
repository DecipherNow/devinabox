SHELL := /bin/bash

all: setup verify-terraform-version
	./apply.sh

setup: config
	packer build -var="aws_profile=$(profile)" -var="subnet_id=$(subnet_id)" packer.json
	@rm -f .credentials > /dev/null 2>&1

config:
	./config.sh

destroy: verify-terraform-version
	./destroy.sh

apply: verify-terraform-version
	./apply.sh

packer:
	packer build -var="aws_profile=$(profile)" -var="subnet_id=$(subnet_id)" packer.json
	@rm -f .credentials > /dev/null 2>&1

verify-terraform-version:
	$(eval TFCHECK=$(shell cd terraform; terraform plan -target=terraform.required_version > /dev/null 2>&1; echo $$?))
	@if [ ${TFCHECK} -ne 0 ]; then \
		echo "Error: Your terraform version is not valid for this configuration."; \
		exit 2 ; \
	fi
