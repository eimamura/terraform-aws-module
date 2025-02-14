output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "alb_target_group_arn" {
  description = "ARN of the ECS Target Group"
  value       = aws_lb_target_group.this.arn
}
