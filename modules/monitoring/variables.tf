variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group to monitor"
  type        = string
}

variable "rds_identifier" {
  description = "Identifier of the RDS instance to monitor"
  type        = string
}

variable "alb_arn_suffix" {
  description = "ARN suffix of the ALB (used in CloudWatch metric dimensions)"
  type        = string
}

variable "alarm_email" {
  description = "Email address for SNS alarm notifications"
  type        = string
}

variable "cpu_alarm_threshold" {
  description = "CPU percentage that triggers the high-CPU alarm"
  type        = number
  default     = 80
}
