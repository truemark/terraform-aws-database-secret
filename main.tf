resource "random_password" "secret" {
  count = var.create ? 1 : 0
  length  = var.password_length
  special = false
  min_upper = 1
  min_lower = 1
  min_numeric = 1
}

resource "aws_secretsmanager_secret" "secret" {
  count = var.create ? 1 : 0
  name_prefix = "database/${var.host}/${var.name}-"
  description = "Application password for ${var.name} on ${var.host}"
  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "secret" {
  count = var.create ? 1 : 0
  secret_id = aws_secretsmanager_secret.secret[count.index].id
  secret_string = jsonencode({
    host = var.host
    port = var.port
    dbname = var.dbname == null ? var.name : var.dbname
    username = var.username == null ? var.name : var.username
    connect_string = var.connect_string
    service_name = var.service_name
    password = random_password.secret[count.index].result
  })
}


