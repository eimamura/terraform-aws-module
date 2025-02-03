# For Public EC2 Instance
module "public_ec2" {
  source                  = "./modules/ec2"
  ami_id                  = data.aws_ami.amazon_linux_2.id
  instance_type           = var.instance_type
  key_name                = var.key_name
  security_group_ids      = [module.sg.ssh_only_sg]
  instance_name           = "ec2-public-${var.project}"
  tags                    = var.tags
  create_in_public_subnet = true                            # Explicitly set to true for public subnet
  subnet_id               = module.vpc.public_subnet_ids[0] # First one of list Public subnet ID
}

# For Private EC2 Instance
module "private_ec2" {
  source                  = "./modules/ec2"
  ami_id                  = data.aws_ami.amazon_linux_2.id
  instance_type           = var.instance_type
  key_name                = var.key_name
  security_group_ids      = [module.sg.ssh_only_sg]
  instance_name           = "ec2-private-${var.project}"
  tags                    = var.tags
  create_in_public_subnet = false                            # Explicitly set to false for private subnet
  subnet_id               = module.vpc.private_subnet_ids[0] # First one of list Private subnet ID
}
