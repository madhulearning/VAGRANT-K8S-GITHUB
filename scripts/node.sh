#!/bin/bash

# Join the Kubernetes cluster
if [ -f /vagrant/join-command.sh ]; then
  bash /vagrant/join-command.sh
else
  echo "Join command not found. Please run 'kubeadm token create --print-join-command' on the master node and save it to 'join-command.sh'."
  exit 1
fi