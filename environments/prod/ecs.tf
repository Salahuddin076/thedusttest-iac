module "ecs" {
  source = "../../modules/compute/ecs"

  environment  = var.environment
  project      = var.project
  cluster_name = var.cluster_name
  tags         = local.common_tags
}
