#!/bin/bash

downloadAndInstall() {
    curl -Lo $1 $2
    chmod +x $1
    mv $1 -t ~/bin
}

BASEURL="https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-kvm2"
APP=docker-machine-driver-kvm2

downloadAndInstall $APP $BASEURL

downloadAndInstall minikube https://github.com/kubernetes/minikube/releases/download/v1.4.0/minikube-linux-amd64

KVMURL="https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.10.0/docker-machine-driver-kvm-ubuntu16.04"
KVMONE=docker-machine-driver-kvm

downloadAndInstall $KVMONE $KVMURL

cd /tmp
SHIFTVER="1.34.1"
wget https://github.com/minishift/minishift/releases/download/v$SHIFTVER/minishift-$SHIFTVER-linux-amd64.tgz
tar xzf minishift-$SHIFTVER-linux-amd64.tgz
cp minishift-$SHIFTVER-linux-amd64/minishift $1/bin
chmod +x $1/bin/minishift
rm minishift-$SHIFTVER-linux-amd64.tgz
rm -rf minishift-$SHIFTVER-linux-amd64

OPENSHIFTCTL="https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz"
wget $OPENSHIFTCTL
tar xzf openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
cp openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit/oc $1/bin
chmod +x $1/bin/oc
rm openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz
rm -rf openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit
