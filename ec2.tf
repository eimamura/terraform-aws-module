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
  # setup_ssm = <<-EOF
  #             sudo dnf install -y amazon-ssm-agent
  #             sudo systemctl start amazon-ssm-agent
  #             sudo systemctl enable amazon-ssm-agent
  #             EOF

  # amazon-efs-utils
  # postgresql16
}

# module "public_ec2" {
#   source             = "./modules/ec2"
#   ami_id             = data.aws_ami.amazon_linux_2023.id
#   instance_type      = var.instance_type
#   key_name           = var.key_name
#   security_group_ids = [module.sg.ssh_only_sg, module.sg.http_only_sg]
#   # security_group_ids      = [module.sg["vpc1"].ssh_only_sg, module.sg["vpc1"].http_only_sg]
#   instance_name           = "ec2-public-${var.project}-bastion"
#   tags                    = var.tags
#   create_in_public_subnet = true                            # Explicitly set to true for public subnet
#   subnet_id               = module.vpc.public_subnet_ids[0] # First one of list Public subnet ID
#   # subnet_id = module.vpc["vpc1"].public_subnet_ids[0]
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
#   source        = "./modules/ec2"
#   ami_id        = data.aws_ami.amazon_linux_2023.id
#   instance_type = var.instance_type
#   key_name      = var.key_name
#   # security_group_ids      = [module.sg.ssh_only_sg, module.sg.http_only_sg]
#   security_group_ids      = [module.sg_for_peering["vpc1"].ssh_only_sg, module.sg_for_peering["vpc1"].http_only_sg]
#   instance_name           = "ec2-private-${var.project}"
#   tags                    = var.tags
#   create_in_public_subnet = false # Explicitly set to false for private subnet
#   # subnet_id               = module.vpc.private_subnet_ids[0] # First one of list Private subnet ID
#   subnet_id = module.vpc_for_peering["vpc1"].private_subnet_ids[0]
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
#   source        = "./modules/ec2"
#   ami_id        = data.aws_ami.amazon_linux_2023.id
#   instance_type = var.instance_type
#   key_name      = var.key_name
#   # security_group_ids      = [module.sg.ssh_only_sg, module.sg.http_only_sg]
#   security_group_ids      = [module.sg_for_peering["vpc2"].ssh_only_sg, module.sg_for_peering["vpc2"].http_only_sg]
#   instance_name           = "ec2-private-${var.project}-2"
#   tags                    = var.tags
#   create_in_public_subnet = false # Explicitly set to false for private subnet
#   # subnet_id               = module.vpc.private_subnet_ids[1]
#   subnet_id = module.vpc_for_peering["vpc2"].private_subnet_ids[1]
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


# # Create an IAM role for EC2 to access S3
# module "ec2_access_s3_role" {
#   source              = "./modules/iam_role"
#   role_name           = "ec2-s3-access-role"
#   assume_role_service = "ec2.amazonaws.com"
#   policy_json         = file("policies/ec2-s3-policy.json")
# }

# # Attach the SSM policy to the IAM role
# resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
#   role       = module.ec2_access_s3_role.iam_role_name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
# }

# # Create an instance profile for EC2 to access S3
# resource "aws_iam_instance_profile" "ec2_instance_profile" {
#   name = "ec2-s3-access-profile"
#   role = basename(module.ec2_access_s3_role.iam_role_arn)
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
