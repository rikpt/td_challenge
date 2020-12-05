#Terraform phase
cd /home/talkdesk_challenge/terraform_config
terraform init -input=false
terraform plan -var-file=main.auto.tfvars  -out=tfplan
#terraform apply tfplan -auto-approve
terraform apply tfplan

#Ansible phase - single container instance
#cd /home/talkdesk_challenge/ansible_config/
#ansible-playbook -i hosts run_mario.yaml -e 'ansible_python_interpreter=/usr/bin/python3'

#Ansible phase - replica with docker service instance
cd /home/talkdesk_challenge/ansible_config_replica/
ansible-playbook -i hosts run_mario_replica.yaml -e 'ansible_python_interpreter=/usr/bin/python3'
