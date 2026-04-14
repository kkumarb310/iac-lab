output "db_instance_id" {
  description = "ID of the RDS instance"
  value       = aws_db_instance.this.id
}

output "db_instance_arn" {
  description = "ARN of the RDS instance"
  value       = aws_db_instance.this.arn
}

output "db_endpoint" {
  description = "Connection endpoint for the RDS instance (host:port)"
  value       = aws_db_instance.this.endpoint
  sensitive   = true
}

output "db_address" {
  description = "Hostname of the RDS instance (without port)"
  value       = aws_db_instance.this.address
  sensitive   = true
}

output "db_port" {
  description = "Port the RDS instance is listening on"
  value       = aws_db_instance.this.port
}

output "db_name" {
  description = "Name of the default database"
  value       = aws_db_instance.this.db_name
}

output "security_group_id" {
  description = "ID of the RDS security group"
  value       = aws_security_group.this.id
}
