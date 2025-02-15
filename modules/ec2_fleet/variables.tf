variable "launch_template_id" {
  description = "The ID of the launch template"
  type        = string
}

variable "latest_version" {
  description = "The version of the launch template"
  type        = string
}

variable "target_capacity" {
  description = "The target capacity for the EC2 fleet"
  type        = number
}
