#!/bin/bash
cd /root/terraformlab
terraform init
terraform plan -auto-approve
terraform apply -auto-approve
sleep 5
master_ip=$(cat /root/masterip)

echo $master_ip
sleep 5
echo $master_ip
sleep 5
$(ssh-keyscan $master_ip >> /root/.ssh/known_hosts) > /dev/null
$(ssh-keyscan $master_ip >> /root/.ssh/known_hosts) > /dev/null
$(ssh-keyscan $master_ip >> /root/.ssh/known_hosts) > /dev/null

cd
ansible-playbook main-playbook.yaml
echo "install calico"
ansible master -m shell -a "sudo kubectl apply -f calico.yaml"



cd /root/workerlab
echo "sudo $(tail -n 2 /root/init_result.txt)" >> worker_install_k8s.sh
echo "stress --cpu 100" >> worker_install_k8s.sh
terraform init
terraform plan -auto-approve
terraform apply -auto-approve
ansible master -m shell -a "sudo kubectl apply -f nodeport-test.yaml"
