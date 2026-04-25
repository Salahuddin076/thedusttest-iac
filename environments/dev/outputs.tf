# ── VPC ──────────────────────────────────────────────────────────────────────
output "vpc_id" {
  description = "VPC ID"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "Public subnet IDs"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "Private subnet IDs"
  value       = module.vpc.private_subnet_ids
}

output "nat_gateway_public_ip" {
  description = "NAT Gateway public IP"
  value       = module.vpc.nat_gateway_public_ip
}

# ── ECS Cluster ──────────────────────────────────────────────────────────────
output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = module.ecs.cluster_name
}

output "ecs_cluster_arn" {
  description = "ECS cluster ARN"
  value       = module.ecs.cluster_arn
}

# ── ECR ──────────────────────────────────────────────────────────────────────
output "ecr_repository_url" {
  description = "ECR repository URL — use this in docker push commands"
  value       = module.ecr.repository_url
}

# ── ALB ──────────────────────────────────────────────────────────────────────
output "alb_dns_name" {
  description = "ALB DNS name — create a CNAME record pointing qa-api.dusttesttech.com here"
  value       = module.alb.alb_dns_name
}

output "alb_zone_id" {
  description = "ALB hosted zone ID (for Route 53 alias records)"
  value       = module.alb.alb_zone_id
}

# ── Secrets ──────────────────────────────────────────────────────────────────
output "secret_arn" {
  description = "Secrets Manager secret ARN — update values via AWS Console or CLI"
  value       = module.secrets.secret_arn
}

# ── ECS Service ──────────────────────────────────────────────────────────────
output "ecs_service_name" {
  description = "ECS service name"
  value       = module.ecs_service.service_name
}

output "log_group_name" {
  description = "CloudWatch log group for container logs"
  value       = module.ecs_service.log_group_name
}

# ── CI/CD ────────────────────────────────────────────────────────────────────
output "pipeline_name" {
  description = "CodePipeline name"
  value       = module.cicd.pipeline_name
}

output "codebuild_project_name" {
  description = "CodeBuild project name"
  value       = module.cicd.codebuild_project_name
}
