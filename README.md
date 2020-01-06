# DevInABox

This project hopes to provide any Decipher programmer with the ability to launch an EC2 instance with all the needed dependencies to launch Greymatter in minikube.
DevInABox works in a couple of stages. First it configures the repository by letting you specify your AWS credentials and ssh public keys. Next it creates an AMI on your AWS account using Packer and Ansible. Finally it launches an EC2 instance using Terraform.

### Prerequisites

Clone this repo onto your local machine.
If you don't already have terraform, ansible, make, or packer installed run the `./prereqs.sh` script to install those. (Works for either Ubuntu or Mac).

### Post Install

After running `make apply` or `make` you can ssh into a brand new ec2 instance. This instance will have a `helm-charts` folder in the home folder. `cd helm-charts` and then run `make fresh` to deploy Greymatter inside your ec2 instance.

## Quickstart

`make`

Running make will perform configuration, build the ami with packer, and launch an instance with Terraform. This will take ~15 minutes to run.

`make setup`

Will run the config and build the AMI.

## Config
`make config`

Runs an interactive dialog for configuring DevInABox.

## Packer
`make packer`

Makes the AMI using Packer. This will take ~10 minutes to run.

## Terraform
`make apply`

This will launch the instance. This will tak ~5 minutes to run.

`make destroy`

This will destroy the instance. Yay! Good for keeping the AWS bill down.
