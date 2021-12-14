resource "random_password" "secret" {
  count       = var.create ? 1 : 0
  length      = var.password_length
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}

resource "aws_secretsmanager_secret" "secret" {
  count       = var.create ? 1 : 0
  name_prefix = "database/${var.host}/${var.username}-"
  description = "Application password for ${var.username} on ${var.host}"
  tags        = var.tags
}

resource "aws_secretsmanager_secret_version" "secret" {
  count     = var.create ? 1 : 0
  secret_id = aws_secretsmanager_secret.secret[count.index].id
  secret_string = jsonencode({
    host           = var.host
    port           = var.port
    dbname         = var.dbname
    username       = var.username
    connect_string = var.connect_string
    engine         = var.engine
    password       = random_password.secret[count.index].result
  })
}


