variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "container_port" {
  description = "Container port ECS tasks listen on"
  type        = number
  default     = 3000
}

variable "ecs_sg_name" {
  description = "Name for the ECS task security group"
  type        = string
}

variable "alb_sg_name" {
  description = "ALB security group name (defaults to <project>-alb-sg when empty)"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
