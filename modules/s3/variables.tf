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
