output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "alb_arn_suffix" {
  description = "ARN suffix of the ALB (used by CloudWatch metrics)"
  value       = aws_lb.main.arn_suffix
}

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.app.name
}

output "ec2_security_group_id" {
  description = "ID of the EC2 security group (used by RDS module)"
  value       = aws_security_group.ec2.id
}

output "s3_bucket_name" {
  description = "Name of the static assets S3 bucket"
  value       = aws_s3_bucket.static_assets.bucket
}

output "scale_up_policy_arn" {
  description = "ARN of the scale-up autoscaling policy"
  value       = aws_autoscaling_policy.scale_up.arn
}

output "scale_down_policy_arn" {
  description = "ARN of the scale-down autoscaling policy"
  value       = aws_autoscaling_policy.scale_down.arn
}
