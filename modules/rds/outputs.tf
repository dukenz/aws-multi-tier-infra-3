output "db_endpoint" {
  description = "RDS instance connection endpoint"
  value       = aws_db_instance.main.endpoint
  sensitive   = true
}

output "db_name" {
  description = "Name of the database"
  value       = aws_db_instance.main.db_name
}

output "db_identifier" {
  description = "RDS instance identifier (used by CloudWatch)"
  value       = aws_db_instance.main.identifier
}

output "db_port" {
  description = "Port the database listens on"
  value       = aws_db_instance.main.port
}

output "rds_security_group_id" {
  description = "Security group ID attached to RDS"
  value       = aws_security_group.rds.id
}
