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
  secret_arn              = module.secrets.secret_arn
  secret_name             = module.secrets.secret_name
  tags                    = local.common_tags
}
