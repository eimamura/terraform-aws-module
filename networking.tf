# module "vpc" {
#   source          = "./modules/vpc"     # Path to the VPC module
#   cidr_block      = var.cidr_block      # CIDR block for the VPC
#   public_subnets  = var.public_subnets  # Public subnets CIDR
#   private_subnets = var.private_subnets # Private subnets CIDR
#   vpc_name        = var.vpc_name        # VPC name
#   instance_type   = var.instance_type   # EC2 instance type
#   key_name        = var.key_name        # EC2 key pair name
#   tags            = var.tags            # Tags for resources
#   enable_nat      = false
# }

# module "sg" {
#   source  = "./modules/security_group"
#   vpc_id  = module.vpc.vpc_id
#   project = var.project
# }
