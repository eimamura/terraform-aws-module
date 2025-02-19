variable "lb_name" {}
variable "internal" { default = false }
variable "lb_type" { default = "application" }
variable "security_groups" {}
variable "subnets" {}
variable "enable_deletion_protection" { default = false }

variable "target_group_name" {}
variable "target_group_port" {}
variable "target_group_protocol" { default = "HTTP" }
variable "target_type" { default = "instance" }
variable "vpc_id" {}

variable "health_check_interval" { default = 30 }
variable "health_check_path" { default = "/" }
variable "health_check_timeout" { default = 5 }
variable "healthy_threshold" { default = 3 }
variable "unhealthy_threshold" { default = 3 }

variable "listener_port" {}
variable "listener_protocol" { default = "HTTP" }

variable "tags" { default = {} }

variable "ec2_instance_ids" {
  type = list(string)
}

variable "certificate_arn" {}
