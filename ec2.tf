locals {
  setup_nginx = <<-EOF
            #!/bin/bash
            sudo yum update -y
            sudo yum install -y nginx make
            sudo systemctl start nginx
            sudo systemctl enable nginx
            echo "<html><body><h1>Hello World from public subnet 0 (Bastion)</h1></body></html>" > /usr/share/nginx/html/index.html
            sudo systemctl restart nginx
            EOF
  # setup_efs   = <<-EOF
  #           mkdir -p /mnt/efs
  #           echo "${aws_efs_file_system.example.dns_name}:/ /mnt/efs efs defaults,_netdev 0 0" | sudo tee -a /etc/fstab
  #           sudo mount -a
  #           EOF

  # amazon-efs-utils
  # postgresql16
}


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
#   # iam_instance_profile    = aws_iam_instance_profile.ec2_instance_profile.name
#   # use_spot_instance = true
#   user_data = <<-EOF
#             #!/bin/bash
#             ${local.setup_nginx}
#             EOF
# }
# output "bastion_ip" {
#   value = module.public_ec2.instance_public_ip
# }

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
#   # iam_instance_profile    = aws_iam_instance_profile.ec2_instance_profile.name
#   user_data = <<-EOF
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
#   # iam_instance_profile    = aws_iam_instance_profile.ec2_instance_profile.name
#   user_data = <<-EOF
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

# module "launch_template" {
#   source          = "./modules/launch_template"
#   name            = "my-launch-template"
#   image_id        = data.aws_ami.amazon_linux_2023.id
#   instance_type   = var.instance_type
#   key_name        = var.key_name
#   security_groups = [module.sg.ssh_only_sg, module.sg.http_only_sg]
#   subnet_id       = module.vpc.public_subnet_ids[0] # First one of list Public subnet ID
#   user_data       = local.setup_nginx
#   tags            = var.tags
#   # iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
# }

# module "ec2_fleet" {
#   source             = "./modules/ec2_fleet"
#   launch_template_id = module.launch_template.launch_template_id
#   latest_version     = "$Latest"
#   target_capacity    = 2
# }

# resource "aws_autoscaling_group" "example" {
#   name                      = "example-asg"
#   desired_capacity          = 2
#   min_size                  = 1
#   max_size                  = 3
#   vpc_zone_identifier       = module.vpc.public_subnet_ids
#   force_delete              = true
#   health_check_type         = "ELB" # Can be either "EC2" or "ELB"
#   health_check_grace_period = 300
#   # wait_for_capacity_timeout = "0"

#   launch_template {
#     id      = module.launch_template.launch_template_id
#     version = "$Latest"
#   }
#   tag {
#     key                 = "Name"
#     value               = "autoscaling-group-instance"
#     propagate_at_launch = true
#   }
# }

# # Create a new load balancer attachment
# resource "aws_autoscaling_attachment" "example" {
#   autoscaling_group_name = aws_autoscaling_group.example.name
#   lb_target_group_arn    = module.load_balancer.alb_target_group_arn
# }
