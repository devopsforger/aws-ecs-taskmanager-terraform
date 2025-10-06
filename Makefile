.PHONY: stage-plan stage-apply prod-plan prod-apply debug-stage

# Auto-detect all tfvars files for each environment
STAGE_TFVARS := $(wildcard environments/stage/*.tfvars)
PROD_TFVARS := $(wildcard environments/prod/*.tfvars)

# Convert file list to -var-file flags
STAGE_FLAGS := $(foreach file,$(STAGE_TFVARS),-var-file=$(file))
PROD_FLAGS := $(foreach file,$(PROD_TFVARS),-var-file=$(file))

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