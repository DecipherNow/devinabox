#!/bin/bash

#Check which operating system we are using.


linux() {
    sudo apt install packer ansible awscli build-essential
    wget -q -O - https://tjend.github.io/repo_terraform/repo_terraform.key | sudo apt-key add -
    sudo echo 'deb [arch=amd64] https://tjend.github.io/repo_terraform stable main' > /tmp/list 
    sudo mv /tmp/list /etc/apt/sources.list.d/terraform.list
    sudo apt-get update
    sudo apt-get install terraform
}

mac() {
    brew install ansible terraform packer awscli make
}

MACHINE=$(uname -s)

case "$MACHINE" in 
    Linux*)  linux;;
    Darwin*) mac;;
    *) linux;;
esac
