# Load environment variables from .env file
include .env
export $(shell sed 's/=.*//' .env)

# Variables
TF_CMD = terraform
KEY_FILE = awstest-keypair.pem

# Targets
.PHONY: i p a d scp bastion chmod p1 p2

i:
	$(TF_CMD) init

p:
	$(TF_CMD) plan

a:
	$(TF_CMD) apply --auto-approve

d:
	$(TF_CMD) destroy --auto-approve

scp:
	scp -i $(KEY_FILE) $(KEY_FILE) ec2-user@$(BASTION_IP):~/

bastion:
	ssh -i "$(KEY_FILE)" ec2-user@$(BASTION_IP)

chmod:
	chmod 400 $(KEY_FILE)

p1:
	ssh -i "$(KEY_FILE)" ec2-user@$(P1_IP)

p2:
	ssh -i "$(KEY_FILE)" ec2-user@$(P2_IP)
