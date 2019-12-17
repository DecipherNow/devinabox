#!/bin/bash

cd $(dirname "${BASH_SOURCE[0]}")

RC=$(ls .keyloc)
if [ ${RC} ]; then
  . .keyloc
fi 
ARGS=""
if [ ! -z ${PUBKEY} ]; then
  absolute="$(cd $(dirname $PUBKEY); pwd)/$(basename $PUBKEY)"
  ARGS="--var public_key_path=$absolute"
fi
cd terraform
terraform init
terraform apply $ARGS -auto-approve
echo -e "\nRun the following command to access the machine. You may need to specify your private key with -i <privkey> :\nssh ubuntu@$(terraform output ec2ip)"
sleep 30s
