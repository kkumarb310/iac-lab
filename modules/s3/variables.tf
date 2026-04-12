variable "project" {
  description = "Project name prefix for all resources"
  type        = string
}

variable "suffix" {
  description = "Random suffix for unique bucket naming"
  type        = string
}

variable "tags" {
  description = "Tags applied to all resources in this module"
  type        = map(string)
}

variable "lifecycle_rules" {
  description = "Map of lifecycle rules to apply to the bucket"
  type = map(object({
    enabled                    = bool
    expiration_days            = number
    noncurrent_expiration_days = number
  }))
  default = {}
}