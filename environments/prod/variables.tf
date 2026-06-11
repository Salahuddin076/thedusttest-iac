variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "aws_profile" {
  description = "AWS CLI profile"
  type        = string
  default     = "tdt"
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
  default     = "054037132427"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "prod"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "thedusttest"
}

variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
  default     = "prod-tdt-cluster"
}

# ── ECR ───────────────────────────────────────────────────────────────────────
variable "ecr_repository_name" {
  description = "ECR repository name"
  type        = string
  default     = "tdt-prod-partner-api-repo"
}

# ── Security Groups ───────────────────────────────────────────────────────────
variable "ecs_sg_name" {
  description = "ECS task security group name"
  type        = string
  default     = "tdt-prod-partner-api-sg"
}

variable "alb_sg_name" {
  description = "ALB security group name"
  type        = string
  default     = "tdt-prod-alb-sg"
}

variable "container_port" {
  description = "Container port"
  type        = number
  default     = 3000
}

# ── ALB ───────────────────────────────────────────────────────────────────────
variable "alb_name" {
  description = "ALB name"
  type        = string
  default     = "tdt-prod-partner-api-alb"
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/api/health"
}

variable "certificate_arn" {
  description = "ACM certificate ARN (*.thedusttest.com)"
  type        = string
  default     = "arn:aws:acm:us-east-2:054037132427:certificate/88851174-2018-476f-a99d-c3ebb8581578"
}

# ── Secrets ───────────────────────────────────────────────────────────────────
variable "secret_name" {
  description = "Secrets Manager secret name"
  type        = string
  default     = "tdt-prod-partner-api-secrets"
}

# ── ECS Service ───────────────────────────────────────────────────────────────
variable "service_name" {
  description = "ECS service name"
  type        = string
  default     = "tdt-prod-partner-api-service"
}

variable "container_name" {
  description = "Container name in task definition"
  type        = string
  default     = "tdt-prod-partner-api"
}

variable "task_cpu" {
  description = "Task CPU units (1024 = 1 vCPU)"
  type        = number
  default     = 1024
}

variable "task_memory" {
  description = "Task memory in MB (2048 = 2 GB)"
  type        = number
  default     = 2048
}

variable "desired_count" {
  description = "Desired number of running ECS tasks"
  type        = number
  default     = 1
}

variable "min_capacity" {
  description = "Minimum number of tasks for auto-scaling"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of tasks for auto-scaling"
  type        = number
  default     = 10
}

# ── Auto-scaling ──────────────────────────────────────────────────────────────
variable "scale_cpu_threshold" {
  description = "CPU utilisation % that triggers scale-out"
  type        = number
  default     = 75
}

variable "scale_memory_threshold" {
  description = "Memory utilisation % that triggers scale-out"
  type        = number
  default     = 75
}

variable "scale_evaluation_periods" {
  description = "Consecutive 60-second periods above threshold before scaling out (2 = 2 minutes)"
  type        = number
  default     = 2
}

# ── CI/CD ─────────────────────────────────────────────────────────────────────
variable "auto_trigger" {
  description = "Whether the pipeline auto-triggers on branch push"
  type        = bool
  default     = false
}

variable "codestar_connection_arn" {
  description = "AWS CodeConnections ARN for GitHub"
  type        = string
  default     = "arn:aws:codeconnections:us-east-2:054037132427:connection/5ff50115-9423-46c9-9b19-88ece9723b7e"
}

variable "github_repo" {
  description = "GitHub repository (owner/repo)"
  type        = string
  default     = "techyesweinspect/tdt-partner-api"
}

variable "github_branch" {
  description = "GitHub branch to track"
  type        = string
  default     = "main"
}

# ── RDS ───────────────────────────────────────────────────────────────────────
variable "nat_gateway_eip" {
  description = "NAT Gateway Elastic IP — used to allow cross-VPC MySQL access from ECS tasks"
  type        = string
  default     = "3.18.208.242"
}
