#!/bin/bash

set -x

echo "sudo apt-get update -y"
sudo apt-get update -y &&
sudo apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common &&
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - &&
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y &&
sudo apt-get update -y &&
sudo sudo apt-get install docker-ce docker-ce-cli containerd.io -y &&
sudo usermod -aG docker ubuntu &&
sudo apt install unzip -y &&
sudo apt install git -y &&
sudo add-apt-repository "ppa:ansible/ansible" -y &&
echo "skipped dd-apt-repository"
sudo apt update -y &&
sudo apt install ansible -y &&
sudo apt install dos2unix -y &&


echo "Update done!"