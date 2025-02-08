output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.this.id
}
output "instance_public_ip" {
  value = aws_instance.this.public_ip
}
output "instance_private_ip" {
  value = aws_instance.this.private_ip
}
