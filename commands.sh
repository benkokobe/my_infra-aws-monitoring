# Infra provisioning for the Monitoring tool on AWS

## Terraform life cycle commands
terraform fmt -recursive
terraform init

terraform validate
terraform plan

terraform apply --auto-approve
terraform apply -refresh-only

terraform state
terraform state list

terraform destroy
terraform destroy -auto-approve

##  Push to GitHub
git remote add origin https://github.com/benkokobe/my_infra-aws-monitoring.git
git branch -M main
git push -u origin main

