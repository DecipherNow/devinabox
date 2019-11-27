#!/bin/bash
cd $(dirname "${BASH_SOURCE[0]}")

echo REMINDER: You need to install the awscli, packer, terraform, and ansible for this script to work.
read -p "Do you wish to configure your aws configuration? [yn] " -n 1 yn
echo
case $yn in
    [Yy]* ) aws configure;;
    [Nn]* ) echo -e "\nSkipping";;
    * ) echo -e "\nPlease answer yes or no. Defaulting to no, skipping";;
esac

echo -e "\nThis application will create an aws instance that you will ssh into.\n"
read -p "Do you wish to set a path to the ssh public key you wish to use? [yn] " -n 1 yn
echo
PUBKEY=""
case $yn in
    [Yy]* ) read -p "Path to Public Key: " PUBKEY;;
    [Nn]* ) echo -e "\nSkipping"; exit 0;;
    * ) echo -e "\nPlease answer yes or no. Defaulting to no, skipping"; exit 0;;
esac

if [ -n ${PUBKEY} ]; then
    echo export PUBKEY=$PUBKEY > .keyloc
fi
