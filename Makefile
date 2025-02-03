# Makefile for Terraform commands

# Variables
TF_CMD=terraform

# Targets
.PHONY: i p a d

# Initialize Terraform
i:
	$(TF_CMD) init

# Plan Terraform
p:
	$(TF_CMD) plan

# Apply Terraform
a:
	$(TF_CMD) apply --auto-approve

# Destroy Terraform
d:
	$(TF_CMD) destroy