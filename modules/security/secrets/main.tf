resource "aws_secretsmanager_secret" "main" {
  name                    = var.secret_name
  description             = var.secret_description
  recovery_window_in_days = 7

  tags = merge(var.tags, {
    Name = var.secret_name
  })
}

# Placeholder secret value — update manually via AWS Console or CLI after apply
resource "aws_secretsmanager_secret_version" "main" {
  secret_id = aws_secretsmanager_secret.main.id

  secret_string = jsonencode({
    NODE_ENV    = "production"
    PORT        = "3000"
    DATABASE_URL = "REPLACE_ME"
    API_KEY      = "REPLACE_ME"
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}
