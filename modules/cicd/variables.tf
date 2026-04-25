variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID"
  type        = string
}

variable "service_name" {
  description = "Service name used for naming pipeline resources"
  type        = string
}

variable "container_name" {
  description = "Container name in the ECS task definition"
  type        = string
}

variable "ecr_repository_name" {
  description = "ECR repository name"
  type        = string
}

variable "ecr_repository_arn" {
  description = "ECR repository ARN"
  type        = string
}

variable "ecs_cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "ecs_service_name" {
  description = "ECS service name"
  type        = string
}

variable "task_execution_role_arn" {
  description = "ECS task execution role ARN (for CodePipeline PassRole)"
  type        = string
}

variable "task_role_arn" {
  description = "ECS task role ARN (for CodePipeline PassRole)"
  type        = string
}

variable "codestar_connection_arn" {
  description = "AWS CodeConnections (CodeStar) connection ARN for GitHub"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository in owner/repo format"
  type        = string
}

variable "github_branch" {
  description = "GitHub branch to track"
  type        = string
  default     = "dev"
}

variable "secret_arn" {
  description = "Secrets Manager secret ARN for CodeBuild access"
  type        = string
}

variable "secret_name" {
  description = "Secrets Manager secret name passed to buildspec as ENV_SECRET_NAME"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}
