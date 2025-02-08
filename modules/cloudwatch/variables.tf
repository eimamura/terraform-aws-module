# Log Group Variables
variable "log_group_name" {
  description = "Name of the CloudWatch log group"
  type        = string
}

variable "retention_days" {
  description = "Retention period in days"
  type        = number
  default     = 30
}

# Log Stream Variables
variable "create_log_stream" {
  description = "Whether to create a log stream"
  type        = bool
  default     = false
}

variable "log_stream_name" {
  description = "Name of the CloudWatch log stream"
  type        = string
  default     = "default-stream"
}

# Alarm Variables
variable "create_alarm" {
  description = "Whether to create an alarm"
  type        = bool
  default     = false
}

variable "alarm_name" {
  description = "Name of the CloudWatch alarm"
  type        = string
  default     = "HighCPUAlarm"
}

variable "metric_name" {
  description = "Metric to monitor"
  type        = string
  default     = "CPUUtilization"
}

variable "namespace" {
  description = "Metric namespace"
  type        = string
  default     = "AWS/EC2"
}

variable "comparison_operator" {
  description = "Comparison operator for alarm"
  type        = string
  default     = "GreaterThanThreshold"
}

variable "evaluation_periods" {
  description = "Number of periods for alarm"
  type        = number
  default     = 2
}

variable "period" {
  description = "Evaluation period in seconds"
  type        = number
  default     = 300
}

variable "statistic" {
  description = "Statistic to evaluate"
  type        = string
  default     = "Average"
}

variable "threshold" {
  description = "Threshold for alarm trigger"
  type        = number
  default     = 80
}

variable "alarm_actions" {
  description = "Actions to take when alarm triggers"
  type        = list(string)
  default     = []
}
