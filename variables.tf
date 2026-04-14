variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "ap-southeast-1"
}

variable "project" {
  description = "Project name prefix for all resources"
  type        = string
  default     = "iac-lab"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "db_username" {
  description = "Master username for the RDS MySQL instance"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Master password for the RDS MySQL instance"
  type        = string
  sensitive   = true
}

variable "common_tags" {
  description = "Tags applied to every resource"
  type        = map(string)
  default = {
    project = "iac-lab"
    env     = "dev"
    owner   = "ikshu"
  }
}

