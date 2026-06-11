locals {
  name_prefix  = "${var.environment}-${var.project}"
  cluster_name = var.cluster_name != "" ? var.cluster_name : "${local.name_prefix}-cluster"
}

resource "aws_ecs_cluster" "main" {
  name = local.cluster_name

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = merge(var.tags, {
    Name = local.cluster_name
  })
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name = aws_ecs_cluster.main.name

  capacity_providers = ["FARGATE", "FARGATE_SPOT"]

  # Prefer Spot; fall back to on-demand if Spot is unavailable
  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
    base              = 1
  }

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight            = 0
    base              = 0
  }
}
