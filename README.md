# DevInABox

This project hopes to provide any Decipher programmer with the ability to launch an EC2 instance with all the needed dependencies to launch Greymatter in minikube.
DevInABox works in a couple of stages. First it configures the repository by letting you specify your AWS credentials and ssh public keys. Next it creates an AMI on your AWS account using Packer and Ansible. Finally it launches an EC2 instance using Terraform.

## Quickstart

`make`
Running make will perform configuration, build the ami with packer, and launch an instance with Terraform.

`make`
Will run the config and build the AMI.

## Config
`make config`
Runs an interactive dialog for configuring DevInABox.

## Packer
`make packer`
Makes the AMI using Packer.

## Terraform
`make apply`

This will launch the instance.

`make destroy`

This will destroy the instance. Yay! Good for keeping the AWS bill down.
