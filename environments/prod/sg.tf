module "security_groups" {
  source = "../../modules/networking/sg"

  environment    = var.environment
  project        = var.project
  vpc_id         = data.aws_vpc.shared.id
  container_port = var.container_port
  ecs_sg_name    = var.ecs_sg_name
  alb_sg_name    = var.alb_sg_name
  tags           = local.common_tags
}
