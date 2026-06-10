terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project
    ManagedBy   = "terraform"
  }
}

# ── Shared VPC (owned by dev environment — reused for cost optimisation) ──────
data "aws_vpc" "shared" {
  tags = {
    Name = "${var.project}-vpc"
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.shared.id]
  }
  tags = {
    Type = "public"
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.shared.id]
  }
  tags = {
    Type = "private"
  }
}

# ── ECS Cluster (dedicated prod cluster) ─────────────────────────────────────
module "ecs" {
  source = "../../modules/ecs"

  environment  = var.environment
  project      = var.project
  cluster_name = var.cluster_name
  tags         = local.common_tags
}

# ── ECR Repository ───────────────────────────────────────────────────────────
module "ecr" {
  source = "../../modules/ecr"

  repository_name = var.ecr_repository_name
  tags            = local.common_tags
}

# ── Security Groups ──────────────────────────────────────────────────────────
module "security_groups" {
  source = "../../modules/security-groups"

  environment    = var.environment
  project        = var.project
  vpc_id         = data.aws_vpc.shared.id
  container_port = var.container_port
  ecs_sg_name    = var.ecs_sg_name
  alb_sg_name    = var.alb_sg_name
  tags           = local.common_tags
}

# ── ALB ──────────────────────────────────────────────────────────────────────
module "alb" {
  source = "../../modules/alb"

  alb_name          = var.alb_name
  vpc_id            = data.aws_vpc.shared.id
  public_subnet_ids = data.aws_subnets.public.ids
  alb_sg_id         = module.security_groups.alb_sg_id
  container_port    = var.container_port
  health_check_path = var.health_check_path
  certificate_arn   = var.certificate_arn
  tags              = local.common_tags
}

# ── Secrets Manager ──────────────────────────────────────────────────────────
module "secrets" {
  source = "../../modules/secrets"

  secret_name        = var.secret_name
  secret_description = "App secrets for ${var.project} ${var.environment}"
  tags               = local.common_tags
}

# ── ECS Service ───────────────────────────────────────────────────────────────
module "ecs_service" {
  source = "../../modules/ecs-service"

  environment            = var.environment
  project                = var.project
  aws_region             = var.aws_region
  service_name           = var.service_name
  container_name         = var.container_name
  container_port         = var.container_port
  ecr_repository_url     = module.ecr.repository_url
  ecs_cluster_arn        = module.ecs.cluster_arn
  ecs_cluster_name       = module.ecs.cluster_name
  task_cpu               = var.task_cpu
  task_memory            = var.task_memory
  desired_count          = var.desired_count
  min_capacity           = var.min_capacity
  max_capacity           = var.max_capacity
  private_subnet_ids     = data.aws_subnets.private.ids
  ecs_sg_id              = module.security_groups.ecs_tasks_sg_id
  target_group_arn       = module.alb.target_group_arn
  alb_https_listener_arn = module.alb.https_listener_arn
  secret_arn             = module.secrets.secret_arn

  use_step_scaling         = true
  scale_cpu_threshold      = var.scale_cpu_threshold
  scale_memory_threshold   = var.scale_memory_threshold
  scale_evaluation_periods = var.scale_evaluation_periods

  tags = local.common_tags
}

# ── CI/CD Pipeline ───────────────────────────────────────────────────────────
module "cicd" {
  source = "../../modules/cicd"

  aws_region              = var.aws_region
  aws_account_id          = var.aws_account_id
  service_name            = var.service_name
  container_name          = var.container_name
  ecr_repository_name     = module.ecr.repository_name
  ecr_repository_arn      = module.ecr.repository_arn
  ecs_cluster_name        = module.ecs.cluster_name
  ecs_service_name        = module.ecs_service.service_name
  task_execution_role_arn = module.ecs_service.task_execution_role_arn
  task_role_arn           = module.ecs_service.task_role_arn
  codestar_connection_arn = var.codestar_connection_arn
  github_repo             = var.github_repo
  github_branch           = var.github_branch
  auto_trigger            = false
  secret_arn              = module.secrets.secret_arn
  secret_name             = module.secrets.secret_name
  tags                    = local.common_tags
}
