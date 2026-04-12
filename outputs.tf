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
  value       = aws_dynamodb_table.terraform_lock.name
}

output "aws_account_id" {
  description = "Current AWS account ID"
  value       = data.aws_caller_identity.current.account_id
}

output "aws_region_name" {
  description = "Current AWS region"
  value       = data.aws_region.current.name
}