SHELL := /bin/bash
TF_VERSION=0.13

all: setup
	./apply.sh

setup: config
	packer build packer.json
	rm -f .credentials > /dev/null 2>&1

config:
	./config.sh

destroy: verify-terraform-version
	./destroy.sh

apply: verify-terraform-version
	./apply.sh

packer:
	packer build packer.json
	rm -f .credentials > /dev/null 2>&1

verify-terraform-version:
	$(eval TFCHECK=$(shell terraform version -json | grep terraform_version | awk -F\" '{print $$4}'))
	if [[ ! $(TFCHECK) == ${TF_VERSION}.* ]]; then \
		echo "You need to use terraform version ${TF_VERSION}"; \
		exit 2 ; \
	fi