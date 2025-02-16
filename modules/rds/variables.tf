variable "db_identifier" {}
variable "engine_version" {}
variable "instance_class" {}
variable "allocated_storage" {}
variable "max_allocated_storage" {}
variable "db_username" {}
variable "db_password" {}
variable "secret_name" {}
variable "subnet_ids" { type = list(string) }
variable "security_group_id" {}
variable "backup_retention_period" { default = 0 }
variable "monitoring_interval" { default = 0 }
variable "performance_insights_enabled" { default = false }
variable "deletion_protection" { default = false }
