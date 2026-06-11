variable "alb_name" {
  description = "Name for the Application Load Balancer"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "public_subnet_ids" {
  description = "Public subnet IDs for the ALB"
  type        = list(string)
}

variable "alb_sg_id" {
  description = "Security group ID for the ALB"
  type        = string
}

variable "container_port" {
  description = "Port the containers listen on"
  type        = number
  default     = 3000
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/api/health"
}

variable "certificate_arn" {
  description = "ACM certificate ARN for HTTPS listener"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
