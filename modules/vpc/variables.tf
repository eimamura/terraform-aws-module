variable "enable_nat" {
  type    = bool
  default = false
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16" # Example CIDR block
}

# Define CIDR blocks for public subnets
variable "public_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
  description = "Map of public subnets with their CIDR and Availability Zone"
}

# Define CIDR blocks for private subnets
variable "private_subnets" {
  type = map(object({
    cidr = string
    az   = string
  }))
  description = "Map of private subnets with their CIDR and Availability Zone"
}

variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
  default     = "my-new-vpc"
}

variable "tags" {
  description = "Tags to be applied to resources."
  type        = map(string)
  default = {
    Environment = "dev"
  }
}
