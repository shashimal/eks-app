resource "aws_secretsmanager_secret" "db_secret" {
  name = "database-secret"
}