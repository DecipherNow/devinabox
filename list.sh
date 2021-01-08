#!/bin/bash

cd terraform
deployments=$(ls devinabox_*.tfstate 2>/dev/null | sed 's/devinabox_//g' | sed 's/.tfstate//g')


printf "\n%20s %25s\n" "Devinabox Instance" "ssh user@ip"
for d in ${deployments}; do
    dip=$(cat devinabox_${d}.tfstate | jq -r '.outputs.ec2ip.value' )
    printf "%20s %25s\n" ${d} "ubuntu@${dip}"
    
done
printf "\n"