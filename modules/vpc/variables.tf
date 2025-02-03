variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16" # Example CIDR block
}

# Define CIDR blocks for public subnets
variable "public_subnet_ids" {
  description = "A list of CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24"] # Example public subnet CIDR
}

# Define CIDR blocks for private subnets
variable "private_subnet_ids" {
  description = "A list of CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.2.0/24"] # Example private subnet CIDR
}


variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
  default     = "my-new-vpc"
}

variable "instance_type" {
  description = "The type of the EC2 instance."
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "The name of the EC2 key pair."
  type        = string
}

variable "tags" {
  description = "Tags to be applied to resources."
  type        = map(string)
  default = {
    Environment = "dev"
  }
}
