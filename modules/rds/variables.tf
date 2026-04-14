variable "project" {
  description = "Project name prefix for all resources"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the RDS instance will be deployed"
  type        = string
}

variable "private_subnet_ids" {
  description = "Map of availability zone to private subnet ID for the DB subnet group"
  type        = map(string)
}

variable "app_security_group_id" {
  description = "Security group ID of the application (EC2) allowed to connect on port 3306"
  type        = string
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "engine_version" {
  description = "MySQL engine version"
  type        = string
  default     = "8.0"
}

variable "allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Name of the default database to create"
  type        = string
  default     = "app"
}

variable "db_username" {
  description = "Master username for the RDS instance"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Master password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}
