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
    # encrypt = true
    #  kms_key_id     = "your-kms-key-id"
  }
}
# resource "aws_s3_bucket" "state_bucket" {
#   bucket = "my-terraform-state-bucket-${random_id.suffix.hex}"
# }

provider "aws" {
  region = var.region
}


module "rds" {
  source                = "./modules/rds"
  db_identifier         = "my-postgres-db"
  engine_version        = "16.3"
  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  max_allocated_storage = 100
  db_username           = "myadmin"
  db_password           = var.password
  secret_name           = "rds-postgres-password"
  subnet_ids            = module.vpc.private_subnet_ids
  security_group_id     = module.sg.rds_postgres_sg
}

output "rds_endpoint" {
  value = module.rds.rds_endpoint
}
