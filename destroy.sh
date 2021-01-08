#!/bin/bash

deployments=""

cd $(dirname "${BASH_SOURCE[0]}")

echo -e " ==> Checking deployments... \n"

cd terraform
deployments=$(ls devinabox_*.tfstate 2>/dev/null| sed 's/devinabox_//g' | sed 's/.tfstate//g')

if [ ! -z "$deployments" ]; then
  echo -e "The following deployments have been found.\n"
  for deployment in $deployments
  do
    echo "     $deployment"
  done
  echo -e -n "\nEnter name of deployment you want to destroy: "
  read destroy_target

  if [ ! -z "$destroy_target" ]; then
    state_file="devinabox_${destroy_target}.tfstate"
    echo -e "\n ==> Destroying deployment '$destroy_target'...\n"
    terraform destroy --var deploy_name=$destroy_target --state=$state_file -auto-approve
    remaining_resources=$(terraform state list --state=$state_file)
    if [ -z "$remaining_resources" ]; then
      echo -e "\n ==> Removing empty state file for '$destroy_target'...\n"
      rm -f $state_file ${state_file}.backup
    fi
  else
    echo -e " ==> No deployment specified for destruction.\n"
  fi

else
  echo -e "\n ==> No deployments found.\n"
fi