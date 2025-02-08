# Load environment variables from .env file
include .env
export $(shell sed 's/=.*//' .env)

# Variables
TF_CMD = terraform
KEY_FILE = awstest-keypair.pem
ECS_SERVICE = backend-service

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
login:
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $(ECR_HOST)
push:
	docker push $(ECR_HOST)/$(ECR_REPO_NAME):latest
check:
	aws ecs describe-services --cluster my-cluster --services $(ECS_SERVICE) --query "services[0].desiredCount" --output text
	aws ecs describe-services --cluster my-cluster --services $(ECS_SERVICE) --query "services[0].runningCount" --output text
	aws ecs describe-services --cluster my-cluster --services $(ECS_SERVICE) --query "services[0].pendingCount" --output text
start:
	aws ecs update-service --cluster my-cluster --service $(ECS_SERVICE) --desired-count 1
stop:
	aws ecs update-service --cluster my-cluster --service $(ECS_SERVICE) --desired-count 0