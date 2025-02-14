variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "subnets" {
  description = "The subnets to associate with the ECS service"
}

variable "security_groups" {
  description = "The security groups to associate with the ECS service"
}

# variable "ecs_cluster_name" {
#     description = "The name of the ECS cluster"
#     type        = string
# }

# variable "ecs_task_definition_family" {
#     description = "The family of the ECS task definition"
#     type        = string
# }

variable "ecs_task_execution_role_arn" {
  description = "The ARN of the ECS task execution role"
  type        = string
}

# variable "ecs_task_cpu" {
#     description = "The number of CPU units used by the task"
#     type        = string
#     default     = "256"
# }

# variable "ecs_task_memory" {
#     description = "The amount of memory (in MiB) used by the task"
#     type        = string
#     default     = "512"
# }

variable "ecr_repository_url" {
  description = "The url of the ECR repository"
  type        = string
}

# variable "ecr_image_tag" {
#     description = "The tag of the ECR image"
#     type        = string
#     default     = "latest"
# }

variable "alb_target_group_arn" {
  description = "ARN of the ECS Target Group"
  type        = string
}
