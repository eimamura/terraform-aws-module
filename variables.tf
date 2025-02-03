variable "project" {
  description = "The project name"
  type        = string
  default     = "my"
}

# Define the AWS region for the resources
variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

# Define the CIDR block for the VPC
variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
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

# Define the name of the VPC
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "my-new-vpc"
}

# Define the instance type for resources like EC2
variable "instance_type" {
  description = "The EC2 instance type to use"
  type        = string
  default     = "t2.micro"
}

# Define the SSH key pair to use for EC2 instances
variable "key_name" {
  description = "The EC2 key pair name"
  type        = string
  default     = "my-key-pair"
}

# Define the tags to apply to the resources
variable "tags" {
  description = "A map of tags to apply to the resources"
  type        = map(string)
  default = {
    Name        = "my-resource"
    Environment = "dev"
  }
}
