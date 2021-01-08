#!/bin/bash

cd $(dirname "${BASH_SOURCE[0]}")

RC=$(ls .keyloc)
if [ ${RC} ]; then
  . .keyloc
fi 

while true; do
  deploy_name=$(python python/generate_name.py)
  name_exists=$(ls terraform/devinabox_${deploy_name}.tfstate > /dev/null 2>&1; echo $?)
  [[ $name_exists -ne 0 ]] && break;
done

STATE_FILE="devinabox_${deploy_name}.tfstate"
ARGS="--var deploy_name=$deploy_name"

if [ ! -z ${PUBKEY} ]; then
  absolute="$(cd $(dirname $PUBKEY); pwd)/$(basename $PUBKEY)"
  ARGS="${ARGS} --var public_key_path=$absolute"
fi

cd terraform
echo -e " ==> Creating deployment '${deploy_name}'...\n"
terraform apply --state=$STATE_FILE $ARGS -auto-approve
public_ip=$(terraform output --state=$STATE_FILE ec2ip )

echo -e "\n ==> Waiting for deployment to be ready..."
sleep 30s

echo -e "\nRun the following command to access the machine. You may need to specify your private key with -i <privkey> :\n\n     ssh ubuntu@${public_ip}\n"
