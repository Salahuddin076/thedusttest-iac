module "alb" {
  source = "../../modules/networking/alb"

  alb_name          = var.alb_name
  vpc_id            = data.aws_vpc.shared.id
  public_subnet_ids = data.aws_subnets.public.ids
  alb_sg_id         = module.security_groups.alb_sg_id
  container_port    = var.container_port
  health_check_path = var.health_check_path
  certificate_arn   = var.certificate_arn
  tags              = local.common_tags
}
