#!/bin/bash
rm -rf /[pwd init directory]/init_result.txt
rm -rf /[pwd terraformlab directory]/masterip
sed -i "3,4d" /etc/ansible/hosts
sed -i "50,52d" /root/workerlab/worker_install_k8s.sh

cd [pwd terraformlab directory]
terraform destroy -auto-approve

cd [pwd workerlab directory]
terraform destroy -auto-approve
