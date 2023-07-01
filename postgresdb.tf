data "aws_db_subnet_group" "private" {
  name       = "demo"
}

resource "aws_db_instance" "rds_postgres" {
 identifier = "demo"

 engine              = "postgres"
 replicate_source_db = null
 engine_version      = "12.15"
 instance_class      = "db.t3.micro"
 allocated_storage   = 20
 storage_encrypted   = true
#  kms_key_id          = ""

 # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
 # "Error creating DB Instance: InvalidParameterValue: MasterUsername
 # user cannot be used as it is a reserved word used by the engine"
  username               = var.rds_credentials_global_postgres_username
  password               = var.rds_credentials_global_postgres_password

 port = "5432"
 vpc_security_group_ids = ["sg-08c9a287e9c4a56fb",data.aws_security_group.sg.id]
 db_subnet_group_name = data.aws_db_subnet_group.private.name
 maintenance_window   = "Mon:00:00-Mon:03:00"
 backup_window        = "03:00-06:00"
 # disable backups to create DB faster
 backup_retention_period         = 0
 tags                            = module.label.tags
 enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
 # Snapshot name upon DB deletion
 #  final_snapshot_identifier = "demodb"
 # Database Deletion Protection
 max_allocated_storage="1000"
 deletion_protection         = false
 multi_az                    = false
 auto_minor_version_upgrade  = false
 apply_immediately           = true
 publicly_accessible         = false
 allow_major_version_upgrade = false
 performance_insights_enabled= true
}
locals {
  secrets = {
    # pgusername = var.rds_credentials_postgres.username
    # pgpassword = var.rds_credentials_postgres.password
    username = var.rds_credentials_global_postgres_username
    password = var.rds_credentials_global_postgres_password
  }
}
resource "aws_secretsmanager_secret" "test" {
  name                    = "pg/db/admin"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "test" {
  secret_id     = aws_secretsmanager_secret.test.id
  secret_string = jsonencode(local.secrets)
}