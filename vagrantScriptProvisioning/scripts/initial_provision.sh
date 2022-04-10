#!/bin/bash

# Para si hay que hacer debugging
# set -x
# Actualizamos
apt-get update && apt-get upgrade -y

# Instalamos docker y ansible
apt-get -y install docker.io ansible unzip python3-pip

# Añadimos usuario para docker
usermod -G docker vagrant

adduser minikube
usermod -aG docker minikube


# Instalamos terraform ()
echo "== Terraform ==" # https://www.terraform.io/downloads
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update -y && sudo apt-get install -y terraform

# Instalando Minikube
echo "== Minikube ==" # https://minikube.sigs.k8s.io/docs/start/
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube config set memory 7500

# Instalando kubectl 
echo "== Kubectl ==" # https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
apt-get update -y && apt-get install -y apt-transport-https ca-certificates curl
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-get update -y && apt-get install -y kubectl

su - minikube && minikube start --driver=docker

echo "Provisioning finalizado"