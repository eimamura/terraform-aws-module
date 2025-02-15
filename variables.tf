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

variable "email_address" {
  description = "The email address to receive notifications"
  type        = string
  default     = ""
}

variable "domain_name" {
  description = "The domain name for the resources"
  type        = string
  default     = ""
}

variable "name_servers" {
  description = "The name servers for the domain"
  type        = list(string)
  default     = []
}
