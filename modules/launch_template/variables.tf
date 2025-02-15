variable "name" {
  description = "The name of the launch template"
  type        = string
}

variable "image_id" {
  description = "The ID of the AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
  default     = null
}

variable "security_groups" {
  description = "A list of security group names to associate with"
  type        = list(string)
  default     = []
}

variable "subnet_id" {
  description = "The VPC subnet ID to launch in"
  type        = string
  default     = null
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  type        = string
  default     = null
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to associate with the instance"
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
