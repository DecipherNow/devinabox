# DevInABox

This project hopes to provide any Decipher programmer with the ability to launch an EC2 instance with all the needed dependencies to launch Greymatter in minikube.
DevInABox works in a couple of stages. First it configures the repository by letting you specify your AWS credentials and ssh public keys. Next it creates an AMI on your AWS account using Packer and Ansible. Finally it launches an EC2 instance using Terraform.

After running `make apply` or `make` you can ssh into a brand new ec2 instance. This instance will have a `helm-charts` folder in the home folder. `cd helm-charts` and then run `make fresh` to deploy Greymatter inside your ec2 instance.


### Prerequisites

Clone this repo onto your local machine.
If you don't already have terraform, ansible, make, or packer installed run the `./prereqs.sh` script to install those. (Works for either Ubuntu or Mac).

## Quickstart

`make`

Running make will perform configuration, build the ami with packer, and launch an instance with Terraform.

`make setup`

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
