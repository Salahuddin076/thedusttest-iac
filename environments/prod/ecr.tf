module "ecr" {
  source = "../../modules/compute/ecr"

  repository_name = var.ecr_repository_name
  tags            = local.common_tags
}
