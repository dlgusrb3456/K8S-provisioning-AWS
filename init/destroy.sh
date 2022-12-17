#!/bin/bash
cd
rm -rf joins.txt
rm -rf masterip
sed -i "3,4d" /etc/ansible/hosts
sed -i "50,52d" /root/workerlab/worker_install_k8s.sh

cd /root/terraformlab
terraform destroy -auto-approve

cd /root/workerlab
terraform destroy -auto-approve
