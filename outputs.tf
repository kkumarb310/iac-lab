output "bucket_name" {
  description = "Name of the S3 state bucket"
  value       = aws_s3_bucket.state.bucket
}

output "bucket_arn" {
  description = "ARN of the S3 state bucket"
  value       = aws_s3_bucket.state.arn
}

output "bucket_region" {
  description = "Region of the S3 state bucket"
  value       = var.aws_region
}

output "dynamodb_table_name" {
  description = "DynamoDB table name for Terraform state locking"
  value       = aws_dynamodb_table.terraform_lock.name
}