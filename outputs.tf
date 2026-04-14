output "bucket_name" {
  description = "Name of the S3 state bucket"
  value       = module.s3_state.bucket_name
}

output "bucket_arn" {
  description = "ARN of the S3 state bucket"
  value       = module.s3_state.bucket_arn
}

output "bucket_region" {
  description = "Region of the S3 state bucket"
  value       = var.aws_region
}

output "dynamodb_table_name" {
  description = "DynamoDB table name for Terraform state locking"
  value       = module.dynamodb_lock.table_name
}
output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Map of availability zone to public subnet ID"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Map of availability zone to private subnet ID"
  value       = module.vpc.private_subnet_ids
}

output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2.instance_id
}

output "ec2_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = module.ec2.private_ip
}

output "ec2_security_group_id" {
  description = "ID of the EC2 security group"
  value       = module.ec2.security_group_id
}

output "rds_endpoint" {
  description = "Connection endpoint for the RDS MySQL instance"
  value       = module.rds.db_endpoint
  sensitive   = true
}

output "rds_db_name" {
  description = "Name of the default database on the RDS instance"
  value       = module.rds.db_name
}

output "rds_security_group_id" {
  description = "ID of the RDS security group"
  value       = module.rds.security_group_id
}

output "aws_account_id" {
  description = "Current AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "aws_region_name" {
  description = "Current AWS region"
  value       = data.aws_region.current.name
}

