variable "secret_name" {
  description = "Name of the Secrets Manager secret"
  type        = string
}

variable "secret_description" {
  description = "Description of the secret"
  type        = string
  default     = "Application secrets"
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
