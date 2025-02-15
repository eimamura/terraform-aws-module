output "ssh_only_sg" {
  description = "The name of the security group."
  value       = aws_security_group.ssh_only_sg.id
}

output "http_only_sg" {
  description = "The name of the security group."
  value       = aws_security_group.http_only_sg.id
}

output "alb_sg" {
  description = "The name of the security group."
  value       = aws_security_group.alb_sg.id

}

output "efs_sg" {
  description = "The name of the security group."
  value       = aws_security_group.efs_sg.id
}
