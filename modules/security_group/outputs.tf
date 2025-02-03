output "ssh_only_sg" {
  description = "The name of the security group."
  value       = aws_security_group.ssh_only_sg.id
}
