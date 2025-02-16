resource "aws_secretsmanager_secret" "db_password" {
  name                    = var.secret_name
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "db_password_value" {
  secret_id     = aws_secretsmanager_secret.db_password.id
  secret_string = jsonencode({ "password" = var.db_password })
}

resource "aws_db_subnet_group" "db_subnet" {
  name       = "${var.db_identifier}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "postgres" {
  identifier                   = var.db_identifier
  engine                       = "postgres"
  engine_version               = var.engine_version
  instance_class               = var.instance_class
  allocated_storage            = var.allocated_storage
  max_allocated_storage        = var.max_allocated_storage
  username                     = var.db_username
  password                     = jsondecode(aws_secretsmanager_secret_version.db_password_value.secret_string)["password"]
  db_subnet_group_name         = aws_db_subnet_group.db_subnet.name
  vpc_security_group_ids       = [var.security_group_id]
  backup_retention_period      = var.backup_retention_period
  storage_encrypted            = true
  publicly_accessible          = false
  monitoring_interval          = var.monitoring_interval
  performance_insights_enabled = var.performance_insights_enabled
  deletion_protection          = var.deletion_protection
  skip_final_snapshot          = true
}
