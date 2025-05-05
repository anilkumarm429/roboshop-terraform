dev-apply:
	git pull
	rm -rf .terraform/terraform.tfstate
	terraform init -backend-config=environments\main.tfvars
	terraform apply -auto-approve -var-file environments/dev/main.tfvars

dev-destroy:
	git pull
	rm -rf .terraform/terraform.tfstate
	terraform init -backend-config=environments\main.tfvars
	terraform destroy -auto-approve -var-file environments/dev/main.tfvars

