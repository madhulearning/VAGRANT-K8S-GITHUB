# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

# Kubernetes cluster configuration
MASTER_IP = "192.168.56.10"
NODE_01_IP = "192.168.56.11"
NODE_02_IP = "192.168.56.12"
POD_CIDR = "10.244.0.0/16"
SERVICE_CIDR = "10.96.0.0/12"

# VM configuration
VM_BOX = "ubuntu/focal64"
MASTER_CPU = 1
MASTER_MEMORY = 2048
NODE_CPU = 1
NODE_MEMORY = 2048

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Configure Master Node
  config.vm.define "k8s-master" do |master|
    master.vm.box = VM_BOX
    master.vm.hostname = "k8s-master"
    master.vm.network "private_network", ip: MASTER_IP
    
    master.vm.provider "virtualbox" do |vb|
      vb.cpus = MASTER_CPU
      vb.memory = MASTER_MEMORY
      vb.name = "k8s-master"
    end
    
    master.vm.provision "shell", path: "scripts/common.sh"
    master.vm.provision "shell", path: "scripts/master.sh", args: [MASTER_IP, POD_CIDR, SERVICE_CIDR]
  end

  # Configure Worker Node 1
  config.vm.define "k8s-node-1" do |node|
    node.vm.box = VM_BOX
    node.vm.hostname = "k8s-node-1"
    node.vm.network "private_network", ip: NODE_01_IP
    
    node.vm.provider "virtualbox" do |vb|
      vb.cpus = NODE_CPU
      vb.memory = NODE_MEMORY
      vb.name = "k8s-node-1"
    end
    
    node.vm.provision "shell", path: "scripts/common.sh"
    node.vm.provision "shell", path: "scripts/node.sh"
  end

  # Configure Worker Node 2
  config.vm.define "k8s-node-2" do |node|
    node.vm.box = VM_BOX
    node.vm.hostname = "k8s-node-2"
    node.vm.network "private_network", ip: NODE_02_IP
    
    node.vm.provider "virtualbox" do |vb|
      vb.cpus = NODE_CPU
      vb.memory = NODE_MEMORY
      vb.name = "k8s-node-2"
    end
    
    node.vm.provision "shell", path: "scripts/common.sh"
    node.vm.provision "shell", path: "scripts/node.sh"
  end
end