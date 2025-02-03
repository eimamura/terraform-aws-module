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


module "load_balancer" {
  source                     = "./modules/load_balancing"
  lb_name                    = "my-alb"
  internal                   = false
  lb_type                    = "application"
  security_groups            = [module.sg.alb_sg]
  subnets                    = module.vpc.public_subnet_ids
  enable_deletion_protection = false

  target_group_name     = "my-target-group"
  target_group_port     = 80
  target_group_protocol = "HTTP"
  target_type           = "instance"
  vpc_id                = module.vpc.vpc_id
  ec2_instance_ids      = [module.private_ec2.instance_id, module.private_ec2_2.instance_id]

  health_check_interval = 30
  health_check_path     = "/"
  health_check_timeout  = 5
  healthy_threshold     = 3
  unhealthy_threshold   = 3

  listener_port     = 80
  listener_protocol = "HTTP"
  tags              = var.tags
}
