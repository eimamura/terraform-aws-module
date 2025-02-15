resource "aws_efs_file_system" "example" {
  creation_token   = "my-product"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  tags             = var.tags
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
}

resource "aws_efs_mount_target" "example" {
  file_system_id  = aws_efs_file_system.example.id
  subnet_id       = module.vpc.public_subnets[0]
  security_groups = [aws_security_group.efs_sg.id]
}
