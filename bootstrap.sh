#!/bin/bash -x

MINIKUBE_RAM=2g
MINIKUBE_DISK_SIZE=5g
export MINIKUBE_DRIVER
UNAMESTR=$(uname)

if [[ "$UNAMESTR" == 'Linux' ]]; then
    MINIKUBE_DRIVER="kvm2"
elif [[ "$UNAMESTR" == 'Darwin' ]]; then
    MINIKUBE_DRIVER="hyperkit"
fi

minikube status >/dev/null || minikube start -p justcars --cpus 2 --memory $MINIKUBE_RAM --disk-size $MINIKUBE_DISK_SIZE --driver $MINIKUBE_DRIVER --wait=all
minikube profile justcars
minikube addons enable ingress
# Skaffold will treat as a local cluster, which means it won't push to remote docker registry
skaffold config set --kube-context justcars local-cluster true

./minikube-update-hosts.sh
