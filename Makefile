.PHONY: stage-init stage-plan stage-apply prod-init prod-plan prod-apply

stage-plan:
	terraform plan -var-file="environments/stage/main.tfvars"

stage-apply:
	terraform apply -var-file="environments/stage/main.tfvars"

stage-destroy:
	terraform destroy -var-file="environments/stage/main.tfvars"

prod-plan:
	terraform plan -var-file="environments/prod/main.tfvars"

prod-apply:
	terraform apply -var-file="environments/prod/main.tfvars"

prod-destroy:
	terraform destroy -var-file="environments/prod/main.tfvars"