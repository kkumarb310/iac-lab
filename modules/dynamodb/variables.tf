variable "project" {
  description = "Project name prefix"
  type        = string
}

variable "tags" {
  description = "Tags applied to all resources"
  type        = map(string)
}

variable "state_bucket_name" {
  description = "Name of the S3 state bucket - passed from s3 module output"
  type        = string
}
