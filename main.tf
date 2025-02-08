terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.84.0"
    }
  }
  backend "s3" {
    bucket = "my-terraform-state-bucket-dfd01bec"
    key    = "dev"
    region = "us-east-1"
  }
}
# resource "aws_s3_bucket" "state_bucket" {
#   bucket = "my-terraform-state-bucket-${random_id.suffix.hex}"
# }

provider "aws" {
  region = var.region
}

module "ecs_task_role" {
  source              = "./modules/iam_role"
  role_name           = "ecs-task-role"
  assume_role_service = "ecs-tasks.amazonaws.com"
  policy_json         = file("policies/ecs-task-policy.json")
}

module "cloudwatch" {
  source            = "./modules/cloudwatch"
  log_group_name    = "/ecs/my-app"
  retention_days    = 1
  create_alarm      = false
  create_log_stream = true
  # alarm_name     = "HighCPUAlarm"
  # metric_name    = "CPUUtilization"
  # namespace      = "AWS/ECS"
  # threshold      = 85
  # alarm_actions  = ["arn:aws:sns:us-east-1:123456789012:notify-me"]
}

module "ecs" {
  source                      = "./modules/ecs"
  project_name                = "my-app"
  subnets                     = module.vpc.public_subnet_ids
  security_groups             = [module.sg.http_only_sg]
  ecs_task_execution_role_arn = module.ecs_task_role.iam_role_arn
}
