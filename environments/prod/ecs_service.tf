module "ecs_service" {
  source = "../../modules/compute/ecs-service"

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

  fargate_on_demand_base = 1

  use_step_scaling         = true
  scale_cpu_threshold      = var.scale_cpu_threshold
  scale_memory_threshold   = var.scale_memory_threshold
  scale_evaluation_periods = var.scale_evaluation_periods

  tags = local.common_tags
}
