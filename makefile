all: setup
	./apply.sh

setup: config
	packer build packer.json

config:
	./config.sh

destroy:
	./destroy.sh

apply:
	./apply.sh

packer:
	packer build packer.json
