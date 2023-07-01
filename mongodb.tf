# data "aws_db_subnet_group" "private" {
#   name       = "demo"
# }
resource "aws_docdb_cluster_instance" "service" {
  count              = 1
  identifier         = "demo" # "tf-${var.name}-${count.index}"
  cluster_identifier = "${aws_docdb_cluster.service.id}"
  instance_class     = "db.t3.medium"
  apply_immediately  = true
  promotion_tier     = 0

}

resource "aws_docdb_cluster" "service" {
  skip_final_snapshot     = false
  db_subnet_group_name    = data.aws_db_subnet_group.private.name
  cluster_identifier      = "demo"
  engine                  = "docdb"
  engine_version          = "3.6.0"
  master_username         = var.docdb_username              #"tf_${replace(var.name, "-", "_")}_admin"
  master_password         = var.docdb_password
  # db_cluster_parameter_group_name = "${aws_docdb_cluster_parameter_group.service.name}"
  vpc_security_group_ids = [data.aws_security_group.sg.id]
  apply_immediately      = true
  storage_encrypted      = true
  tags                   = module.label.tags
}
locals {
  secrets = {
        username = var.docdb_username
        password = var.docdb_password
  }
}
resource "aws_secretsmanager_secret" "test" {
  name                    = "docdb/db/admin"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "test" {
  secret_id     = aws_secretsmanager_secret.test.id
  secret_string = jsonencode(local.secrets)
}