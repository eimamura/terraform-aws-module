variable "project" {
  description = "The project name"
  type        = string
  default     = "my"
}

variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
