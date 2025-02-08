# CloudWatch Log Group
resource "aws_cloudwatch_log_group" "this" {
  name              = var.log_group_name
  retention_in_days = var.retention_days
}

# CloudWatch Metric Alarm
resource "aws_cloudwatch_metric_alarm" "this" {
  count               = var.create_alarm ? 1 : 0
  alarm_name          = var.alarm_name
  comparison_operator = var.comparison_operator
  evaluation_periods  = var.evaluation_periods
  metric_name         = var.metric_name
  namespace           = var.namespace
  period              = var.period
  statistic           = var.statistic
  threshold           = var.threshold
  alarm_actions       = var.alarm_actions
}

# CloudWatch Log Stream (Optional)
resource "aws_cloudwatch_log_stream" "this" {
  count          = var.create_log_stream ? 1 : 0
  name           = var.log_stream_name
  log_group_name = aws_cloudwatch_log_group.this.name
}
