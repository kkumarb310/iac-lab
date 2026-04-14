variable "project" {
  description = "Project name prefix for resource naming"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC to place the instance and security group in"
  type        = string
}

variable "private_subnet_ids" {
  description = "Map of availability zone to private subnet ID"
  type        = map(string)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID to launch. If empty, latest Amazon Linux 2023 is used"
  type        = string
  default     = ""
}

variable "subnet_key" {
  description = "Key from private_subnet_ids map to place the instance in (e.g. ap-southeast-1a)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}
