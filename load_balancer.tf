# module "load_balancer" {
#   source                     = "./modules/load_balancing"
#   lb_name                    = "my-alb"
#   internal                   = false
#   lb_type                    = "application"
#   security_groups            = [module.sg.alb_sg]
#   subnets                    = module.vpc.public_subnet_ids
#   enable_deletion_protection = false

#   target_group_name     = "my-target-group"
#   target_group_port     = 80
#   target_group_protocol = "HTTP"
#   vpc_id                = module.vpc.vpc_id
#   ec2_instance_ids      = null
#   # ec2_instance_ids      = [module.private_ec2.instance_id, module.private_ec2_2.instance_id]
#   # target_type           = "instance"
#   target_type = "ip"

#   health_check_interval = 30
#   health_check_path     = "/"
#   health_check_timeout  = 5
#   healthy_threshold     = 3
#   unhealthy_threshold   = 3

#   listener_port     = 80
#   listener_protocol = "HTTP"
#   tags              = var.tags
# }

# output "alb_dns_name" {
#   value = module.load_balancer.alb_dns_name
# }
