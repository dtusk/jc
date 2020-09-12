#!/bin/bash

UNAMESTR=$(uname) 
LOCAL_HOSTS="local.justcars.pl"
MINIKUBE_IP=$(minikube ip)
echo "Updating $LOCAL_HOSTS to $MINIKUBE_IP"
for LOCAL_HOST in $LOCAL_HOSTS
do

  if grep -Fq "$LOCAL_HOST" /etc/hosts > /dev/null
  then
    # `sed` behaves differently on systems
    if [[ "$UNAMESTR" == "Linux" ]]; then
      sudo sed -i "s/.*$LOCAL_HOST/$MINIKUBE_IP $LOCAL_HOST/" /etc/hosts
    elif [[ "$UNAMESTR" == "Darwin" ]]; then
      sudo sed -i '' "s/.*$LOCAL_HOST/$MINIKUBE_IP $LOCAL_HOST/" /etc/hosts
    fi
  else
    echo "$MINIKUBE_IP $LOCAL_HOST" | sudo tee -a /etc/hosts
  fi

done
