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

variable "common_tags" {
  description = "Tags applied to every resource"
  type        = map(string)
  default = {
    project = "iac-lab"
    env     = "dev"
    owner   = "ikshu"
  }
}
