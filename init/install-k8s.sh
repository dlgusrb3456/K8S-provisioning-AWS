#!/bin/bash
sudo apt update
sudo touch stage1.txt
sudo apt-get install -y ca-certificates curl gnupg lsb-release
sudo touch test2.txt
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo touch test3.txt
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo touch test4.txt
sudo apt-get update
sudo touch test5.txt
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo touch test6.txt
sudo systemctl enable docker
sudo systemctl start docker
echo "install docker succeed"
sudo swapoff -a && sudo sed -i '/ swap / s/^/#/' /etc/fstab


cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sudo sysctl --system

sudo touch test7.txt
sudo ufw disable
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
sudo touch test8.txt
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet=1.25.2-00 kubeadm=1.25.2-00 kubectl=1.25.2-00
sudo apt-mark hold kubelet kubeadm kubectl
sudo touch test9.txt

sudo systemctl start kubelet
sudo systemctl enable kubelet

sudo rm /etc/containerd/config.toml
sudo systemctl restart containerd
echo "install kubernetes succeed"
sudo touch test10.txt
