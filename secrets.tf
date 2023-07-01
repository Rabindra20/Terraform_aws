resource "aws_secretsmanager_secret" "demo" {
  name                    = "path/demo"
  recovery_window_in_days = 0
}

locals {
  demo = {
    hhh="jj"
  }
}
  resource "aws_secretsmanager_secret_version" "demo" {
  secret_id     = aws_secretsmanager_secret.demo.id
  secret_string = jsonencode(local.demo)
}