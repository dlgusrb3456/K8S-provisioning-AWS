#!/bin/bash
rm -rf ./init_result.txt
rm -rf ../terraformlab/masterip
sed -i "3,4d" /etc/ansible/hosts
sed -i "50,52d" ../workerlab/worker_install_k8s.sh

cd ../terraformlab
terraform destroy -auto-approve

cd ../workerlab
terraform destroy -auto-approve
