module "vpc" {
  source             = "./modules/vpc"        # Path to the VPC module
  cidr_block         = var.cidr_block         # CIDR block for the VPC
  public_subnet_ids  = var.public_subnet_ids  # Public subnets CIDR
  private_subnet_ids = var.private_subnet_ids # Private subnets CIDR
  vpc_name           = var.vpc_name           # VPC name
  instance_type      = var.instance_type      # EC2 instance type
  key_name           = var.key_name           # EC2 key pair name
  tags               = var.tags               # Tags for resources
}

module "sg" {
  source  = "./modules/security_group"
  vpc_id  = module.vpc.vpc_id
  project = var.project
}
