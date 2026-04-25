variable "environment" {
  description = "Environment name"
  type        = string
}

variable "cluster_name" {
  description = "Override the ECS cluster name. Leave empty to use the default {environment}-{project}-cluster"
  type        = string
  default     = ""
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default     = {}
}
