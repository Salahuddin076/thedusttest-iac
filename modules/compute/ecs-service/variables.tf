variable "environment" {
  description = "Environment name"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "service_name" {
  description = "ECS service name"
  type        = string
}

variable "container_name" {
  description = "Container name in the task definition"
  type        = string
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 3000
}

variable "ecr_repository_url" {
  description = "ECR repository URL"
  type        = string
}

variable "ecs_cluster_arn" {
  description = "ECS cluster ARN"
  type        = string
}

variable "task_cpu" {
  description = "Task CPU units (256 = 0.25 vCPU)"
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Task memory in MB"
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Desired number of running tasks"
  type        = number
  default     = 1
}

variable "ecs_cluster_name" {
  description = "ECS cluster name (used for auto-scaling resource ID)"
  type        = string
}

variable "min_capacity" {
  description = "Minimum number of tasks for auto-scaling"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of tasks for auto-scaling"
  type        = number
  default     = 4
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for ECS tasks"
  type        = list(string)
}

variable "ecs_sg_id" {
  description = "ECS task security group ID"
  type        = string
}

variable "target_group_arn" {
  description = "ALB target group ARN"
  type        = string
}

variable "alb_https_listener_arn" {
  description = "HTTPS listener ARN (used for dependency ordering)"
  type        = string
}

variable "secret_arn" {
  description = "Secrets Manager secret ARN for app secrets"
  type        = string
}

variable "fargate_on_demand_base" {
  description = "Number of tasks always placed on on-demand FARGATE (set to 1+ for HA envs so Spot interruption never takes the service to zero)"
  type        = number
  default     = 0
}

variable "use_step_scaling" {
  description = "Use step scaling (CloudWatch alarms) instead of target tracking"
  type        = bool
  default     = false
}

variable "scale_cpu_threshold" {
  description = "CPU utilisation % that triggers scale-out (step scaling only)"
  type        = number
  default     = 80
}

variable "scale_memory_threshold" {
  description = "Memory utilisation % that triggers scale-out (step scaling only)"
  type        = number
  default     = 80
}

variable "scale_evaluation_periods" {
  description = "Consecutive 60-second periods above threshold before scaling out (step scaling only)"
  type        = number
  default     = 1
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
