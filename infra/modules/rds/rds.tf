module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~>5.9"

  identifier     = var.identifier
  engine         = var.engine
  engine_version = var.engine_version
  family               = var.family # DB parameter group
  major_engine_version = var.major_engine_version      # DB option group
  instance_class       = var.instance_class

  iam_database_authentication_enabled = false
  username = "admin"

  db_subnet_group_name   = var.database_subnet_group
  vpc_security_group_ids = [module.rds_security_group.security_group_id]
  allocated_storage = 20

  monitoring_interval = 0

  deletion_protection = false
  skip_final_snapshot = true
  storage_encrypted = false
  multi_az = false

}

module "rds_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${var.identifier}-sg"
  description = "RDS security group"
  vpc_id      = var.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      description = "RDS access from within VPC"
      cidr_blocks = var.vpc_cidr
    },
  ]
}

resource "null_resource" "change_rds_password" {
  triggers = {
    updated_count = 1
  }

  provisioner "local-exec" {
    working_dir = path.module
    command     = "${path.module}/rotate-rds-master-password.sh $db_instance_identifier $secret_id"
    environment = {
      secret_id      = aws_secretsmanager_secret.db_secret.name
      db_instance_identifier = var.identifier
    }
  }
}