variable "project" {
  description = "Project name prefix for all resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones for subnet placement"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "Map of public subnet CIDR blocks keyed by availability zone"
  type        = map(string)
}

variable "private_subnet_cidrs" {
  description = "Map of private subnet CIDR blocks keyed by availability zone"
  type        = map(string)
}

variable "tags" {
  description = "Tags applied to all resources in this module"
  type        = map(string)
}

variable "enable_flow_logs" {
  description = "Enable VPC Flow Logs to CloudWatch"
  type        = bool
  default     = true
}

variable "flow_log_retention_days" {
  description = "Number of days to retain VPC Flow Logs in CloudWatch"
  type        = number
  default     = 30
}
