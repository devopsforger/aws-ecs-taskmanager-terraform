.PHONY: stage-plan stage-apply prod-plan prod-apply debug-stage

# terraform state details
TF_STATE_BUCKET_NAME := forger-tfstate-$(shell aws sts get-caller-identity --profile $(AWS_PROFILE) --query "Account" --output text)
AWS_REGION := us-east-1
AWS_PROFILE := hack51

# Auto-detect all tfvars files for each environment
STAGE_TFVARS := $(wildcard environments/stage/*.tfvars)
PROD_TFVARS := $(wildcard environments/prod/*.tfvars)

# Convert file list to -var-file flags
STAGE_FLAGS := $(foreach file,$(STAGE_TFVARS),-var-file=$(file))
PROD_FLAGS := $(foreach file,$(PROD_TFVARS),-var-file=$(file))

init-backend:
	@echo "Creating S3 bucket for Terraform state..."
	aws s3 mb s3://$(TF_STATE_BUCKET_NAME) --region $(AWS_REGION) --profile $(AWS_PROFILE)
	@echo "Enabling versioning on the state bucket..."
	aws s3api put-bucket-versioning \
		--bucket $(TF_STATE_BUCKET_NAME) \
		--versioning-configuration Status=Enabled \
		--profile $(AWS_PROFILE)
	@echo "Terraform backend bucket '$(TF_STATE_BUCKET_NAME)' is ready."

stage-init:
	terraform init -reconfigure -backend-config="./environments/stage/backend.hcl"

prod-init:
	terraform init -reconfigure -backend-config="./environments/prod/backend.hcl"

init-all: stage-init prod-init

stage-plan:
	@echo "Loading stage tfvars: $(STAGE_TFVARS)"
	terraform plan $(STAGE_FLAGS)

stage-apply:
	terraform apply $(STAGE_FLAGS)

prod-plan:
	@echo "Loading prod tfvars: $(PROD_TFVARS)"
	terraform plan $(PROD_FLAGS)

prod-apply:
	terraform apply $(PROD_FLAGS)

# Debug command to see what files are loaded
debug-stage:
	@echo "Stage TFVARS files:"
	@for file in $(STAGE_TFVARS); do echo "  - $$file"; done
	@echo "Flags: $(STAGE_FLAGS)"

debug-prod:
	@echo "Prod TFVARS files:"
	@for file in $(PROD_TFVARS); do echo "  - $$file"; done
	@echo "Flags: $(PROD_FLAGS)"
	
infracost:
	infracost breakdown --path . --show-skipped