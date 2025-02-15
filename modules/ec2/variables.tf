variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
  default     = "t2.micro" # Default instance type
}

variable "subnet_id" {
  description = "The subnet ID where the EC2 instance will be launched"
  type        = string
}

variable "create_in_public_subnet" {
  description = "Flag to determine if the EC2 instance is in the public subnet"
  type        = bool
  default     = true
}

variable "key_name" {
  description = "The name of the SSH key pair"
  type        = string
}

variable "security_group_ids" {
  description = "The IDs of the security groups to assign to the EC2 instances"
  type        = list(string)
}

variable "instance_name" {
  description = "The name for the EC2 instances"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to the EC2 instances"
  type        = map(string)
  default     = {}
}

variable "user_data" {
  description = "User data script to be executed on EC2 instance launch"
  type        = string
  default     = "" # Default is empty, so it doesn't run anything unless passed
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to associate with the EC2 instances"
  type        = string
  default     = "" # Default is empty, so it doesn't associate any instance profile
}

variable "use_spot_instance" {
  description = "Flag to determine if the EC2 instance should be a spot instance"
  type        = bool
  default     = false
}
