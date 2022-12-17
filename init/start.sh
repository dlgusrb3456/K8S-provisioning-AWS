#!/bin/bash
cd [pwd terraformlab directory]
terraform init
terraform plan -auto-approve
terraform apply -auto-approve

sleep 5
master_ip=$(cat ./masterip)

echo $master_ip
sleep 5
echo $master_ip
sleep 5
$(ssh-keyscan $master_ip >> /root/.ssh/known_hosts) > /dev/null
$(ssh-keyscan $master_ip >> /root/.ssh/known_hosts) > /dev/null
$(ssh-keyscan $master_ip >> /root/.ssh/known_hosts) > /dev/null

cd [pwd init directory]
ansible-playbook main-playbook.yaml
echo "install calico"
ansible master -m shell -a "sudo kubectl apply -f calico.yaml"


cd [pwd workerlab directory]
cd /root/workerlab
echo "sudo $(tail -n 2 ../init/init_result.txt)" >> worker_install_k8s.sh
echo "stress --cpu 100" >> worker_install_k8s.sh
terraform init
terraform plan -auto-approve
terraform apply -auto-approve
ansible master -m shell -a "sudo kubectl apply -f nodeport-test.yaml"
