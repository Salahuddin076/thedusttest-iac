module "alb" {
  source = "../../modules/networking/alb"

  alb_name          = var.alb_name
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.security_groups.alb_sg_id
  container_port    = var.container_port
  health_check_path = var.health_check_path
  certificate_arn   = var.certificate_arn
  tags              = local.common_tags
}
