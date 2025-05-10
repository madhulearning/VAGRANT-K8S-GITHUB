#!/bin/bash

MASTER_IP=$1
POD_CIDR=$2
SERVICE_CIDR=$3

# Initialize Kubernetes cluster
kubeadm init --apiserver-advertise-address=$MASTER_IP --pod-network-cidr=$POD_CIDR --service-cidr=$SERVICE_CIDR

# Set up kubectl for vagrant user
mkdir -p /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube

# Set up kubectl for root user
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

# Install Calico CNI
kubectl --kubeconfig=/etc/kubernetes/admin.conf apply -f https://docs.projectcalico.org/v3.21/manifests/calico.yaml

# Generate join command for worker nodes
kubeadm token create --print-join-command > /vagrant/join-command.sh
chmod +x /vagrant/join-command.sh

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

# Install Metrics Server
kubectl --kubeconfig=/etc/kubernetes/admin.conf apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Allow pods to run on master node (optional)
kubectl --kubeconfig=/etc/kubernetes/admin.conf taint nodes --all node-role.kubernetes.io/master-