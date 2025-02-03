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
