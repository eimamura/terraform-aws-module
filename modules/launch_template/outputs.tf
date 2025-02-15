output "launch_template_id" {
  description = "The ID of the launch template"
  value       = aws_launch_template.this.id
}

output "latest_version" {
  description = "The version of the launch template"
  value       = aws_launch_template.this.latest_version
}
