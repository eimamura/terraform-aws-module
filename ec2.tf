# locals {
#   setup_nginx = <<-EOF
#             #!/bin/bash
#             sudo yum update -y
#             sudo yum install -y nginx
#             sudo systemctl start nginx
#             sudo systemctl enable nginx
#             echo "<html><body><h1>Hello World from public subnet 0 (Bastion)</h1></body></html>" > /usr/share/nginx/html/index.html
#             sudo systemctl restart nginx
#             EOF
# }

# # For Public EC2 Instance
# module "public_ec2" {
#   source                  = "./modules/ec2"
#   ami_id                  = data.aws_ami.amazon_linux_2023.id
#   instance_type           = var.instance_type
#   key_name                = var.key_name
#   security_group_ids      = [module.sg.ssh_only_sg, module.sg.http_only_sg]
#   instance_name           = "ec2-public-${var.project}-bastion"
#   tags                    = var.tags
#   create_in_public_subnet = true                            # Explicitly set to true for public subnet
#   subnet_id               = module.vpc.public_subnet_ids[0] # First one of list Public subnet ID
#   user_data               = local.setup_nginx
# }
# output "bastion_ip" {
#   value = module.public_ec2.instance_public_ip
# }

# # For Private EC2 Instance
# module "private_ec2" {
#   source                  = "./modules/ec2"
#   ami_id                  = data.aws_ami.amazon_linux_2023.id
#   instance_type           = var.instance_type
#   key_name                = var.key_name
#   security_group_ids      = [module.sg.ssh_only_sg, module.sg.http_only_sg]
#   instance_name           = "ec2-private-${var.project}"
#   tags                    = var.tags
#   create_in_public_subnet = false                            # Explicitly set to false for private subnet
#   subnet_id               = module.vpc.private_subnet_ids[0] # First one of list Private subnet ID
#   user_data               = <<-EOF
#             #!/bin/bash
#             sudo yum update -y
#             sudo yum install -y nginx
#             sudo systemctl start nginx
#             sudo systemctl enable nginx
#             echo "<html><body><h1>Hello World from private subnet 1</h1></body></html>" > /usr/share/nginx/html/index.html
#             sudo systemctl restart nginx
#             EOF
# }
# output "private1" {
#   value = module.private_ec2.instance_private_ip
# }

# module "private_ec2_2" {
#   source                  = "./modules/ec2"
#   ami_id                  = data.aws_ami.amazon_linux_2023.id
#   instance_type           = var.instance_type
#   key_name                = var.key_name
#   security_group_ids      = [module.sg.ssh_only_sg, module.sg.http_only_sg]
#   instance_name           = "ec2-private-${var.project}-2"
#   tags                    = var.tags
#   create_in_public_subnet = false                            # Explicitly set to false for private subnet
#   subnet_id               = module.vpc.private_subnet_ids[1] # First one of list Private subnet ID
#   user_data               = <<-EOF
#             #!/bin/bash
#             sudo yum update -y
#             sudo yum install -y nginx
#             sudo systemctl start nginx
#             sudo systemctl enable nginx
#             echo "<html><body><h1>Hello World from private subnet 2</h1></body></html>" > /usr/share/nginx/html/index.html
#             sudo systemctl restart nginx
#             EOF
# }
# output "private_2" {
#   value = module.private_ec2_2.instance_private_ip
# }
