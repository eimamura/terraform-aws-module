output "log_group_name" {
  description = "Name of the created CloudWatch log group"
  value       = aws_cloudwatch_log_group.this.name
}

output "log_group_arn" {
  description = "ARN of the created CloudWatch log group"
  value       = aws_cloudwatch_log_group.this.arn
}

output "alarm_arn" {
  description = "ARN of the created CloudWatch alarm"
  value       = var.create_alarm ? aws_cloudwatch_metric_alarm.this[0].arn : null
}
