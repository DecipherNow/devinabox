#!/bin/bash

cd $(dirname "${BASH_SOURCE[0]}")

RC=$(ls .keyloc)
if [ ${RC} ]; then
  . .keyloc
fi 
ARGS=""
if [ -z ${PUBKEY+x} ]; then
  ARGS="$ARGS --var public_key_path=$PUBKEY"
fi
cd terraform
terraform init
terraform apply $ARGS -auto-approve
echo -e "\nRun the following command to access the machine:\nssh -X ubuntu@$(terraform output ec2ip) \n\nYou may need to specify your private key with -i <privkey>."
