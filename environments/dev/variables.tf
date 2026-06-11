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
  default     = "dev"
}

variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
  default     = "dev-qa-tdt-cluster"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "thedusttest"
}

# ── VPC ──────────────────────────────────────────────────────────────────────
variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "13.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["13.0.1.0/24", "13.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["13.0.10.0/24", "13.0.11.0/24"]
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["us-east-2a", "us-east-2b"]
}

# ── ECR ───────────────────────────────────────────────────────────────────────
variable "ecr_repository_name" {
  description = "ECR repository name"
  type        = string
  default     = "tdt-partner-api-repo"
}

# ── Security Groups ───────────────────────────────────────────────────────────
variable "ecs_sg_name" {
  description = "ECS task security group name"
  type        = string
  default     = "tdt-partner-api-sg"
}

variable "alb_sg_name" {
  description = "ALB security group name — defaults to <project>-alb-sg when empty"
  type        = string
  default     = ""
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
  default     = "tdt-partner-api-alb"
}

variable "health_check_path" {
  description = "Health check path"
  type        = string
  default     = "/api/health"
}

variable "certificate_arn" {
  description = "ACM certificate ARN"
  type        = string
  default     = "arn:aws:acm:us-east-2:054037132427:certificate/381f38ec-0e01-4ffe-a5d3-41a71a447a8a"
}

# ── Secrets ───────────────────────────────────────────────────────────────────
variable "secret_name" {
  description = "Secrets Manager secret name"
  type        = string
  default     = "tdt-partner-api-repo-secrets"
}

# ── ECS Service ───────────────────────────────────────────────────────────────
variable "service_name" {
  description = "ECS service name"
  type        = string
  default     = "tdt-partner-api-service"
}

variable "container_name" {
  description = "Container name in task definition"
  type        = string
  default     = "tdt-partner-api"
}

variable "task_cpu" {
  description = "Task CPU units (1024 = 1 vCPU)"
  type        = number
  default     = 1024
}

variable "task_memory" {
  description = "Task memory in MB"
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
  default     = 4
}

# ── CI/CD ─────────────────────────────────────────────────────────────────────
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
  default     = "dev"
}
