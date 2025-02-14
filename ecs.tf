
# module "ecr" {
#   source = "./modules/ecr"
# }

# module "ecs_task_role" {
#   source              = "./modules/iam_role"
#   role_name           = "ecs-task-role"
#   assume_role_service = "ecs-tasks.amazonaws.com"
#   policy_json         = file("policies/ecs-task-policy.json")
# }

# module "cloudwatch" {
#   source            = "./modules/cloudwatch"
#   log_group_name    = "/ecs/my-app"
#   retention_days    = 1
#   create_alarm      = false
#   create_log_stream = true
#   # alarm_name     = "HighCPUAlarm"
#   # metric_name    = "CPUUtilization"
#   # namespace      = "AWS/ECS"
#   # threshold      = 85
#   # alarm_actions  = ["arn:aws:sns:us-east-1:123456789012:notify-me"]
# }

# module "ecs" {
#   source                      = "./modules/ecs"
#   project_name                = "my-app"
#   subnets                     = module.vpc.private_subnet_ids
#   security_groups             = [module.sg.http_only_sg]
#   ecs_task_execution_role_arn = module.ecs_task_role.iam_role_arn
#   ecr_repository_url          = module.ecr.repository_url
#   alb_target_group_arn        = module.load_balancer.alb_target_group_arn
# }
