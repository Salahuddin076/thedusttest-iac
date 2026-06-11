module "secrets" {
  source = "../../modules/security/secrets"

  secret_name        = var.secret_name
  secret_description = "App secrets for ${var.project} ${var.environment}"
  tags               = local.common_tags
}
