# provider "aws" {
#   region     = "us-east-1"
#   access_key = ""
#   secret_key = ""
#   # for sso role in aws
#   token = ""
# }
##local
# data "terraform_remote_state" "local_state" {
#   backend = "local"

#   config = {
#     path = "terraform.tfstate"
#   }
# }
##remote state
# terraform {
#   backend "s3" {
#     bucket ="rab"
#     key ="key/terraform.tfstate"
#     encrypt = true
#     region = "us-east-1"
#   }
# }

# data "terraform_remote_state" "remote_state" {
#   backend = "remote"

#   config = {
#     organization = "lft"
#     workspaces = {
#       name = "test"
#     }
#   }
# }
# module "vpc" {
#   source = "./modules/vpc"
#   environment           = var.environment
#   vpc_cidr              = var.vpc_cidr
#   public_subnets_cidr   = var.public_subnets_cidr
#   private_subnets_cidr  = var.private_subnets_cidr
#   database_subnets_cidr = var.database_subnets_cidr
#   aws_region = "${var.aws_region}"
# }
# output "vpc_cidr" {
#   value = module.vpc_demo.vpc_id
# }

# module "securitygrp" {
#   source = "./modules/securitygrp"

#   vpc_id = "${module.vpc.out_vpc_id}"
#   aws_region = "${var.aws_region}"
#   vpc_cidr_block = "${module.vpc.out_vpc_cidr_block}"
# }

# module "ec2" {
#   source = "./modules/ec2"

#   # vpc_id = "${module.vpc.out_vpc_id}"
#   aws_region = "${var.aws_region}"
#   # key_pair_path = "${var.key_pair_path}"
#   instance_type = "${var.instance_type}"
#   pub_subnet_id = "${module.vpc.out_pub_subnet_id}"
#   #  iam_instance_profile_name = "${module.iam.out_iam_instance_profile_name}"
#   #  user_data_path = "${var.user_data_path}"
#   web_server_sg_id = "${module.securitygrp.out_web_server_sg_id}"
# }
# module "RDS" {
#   source = "./modules/RDS" 

#   db_engine = "${var.db_engine}"
#   engine_version = "${var.engine_version}"
#   db_instance_class = "${var.db_instance_class}"
#   db_identifier = "${var.db_identifier}"
#   db_name = "${var.db_name}"
#   db_username = "${var.db_username}"
#   db_password = "${var.db_password}"
#   db_skip_final_snapshot = "${var.db_skip_final_snapshot}"
#   db_backup_retention_period = "${var.db_backup_retention_period}"
#   rds_subnet_name = "${module.vpc.out_rds_subnet_name}"
#   rds_sg_id = "${module.security-group.out_rds_sg_id}"
#   lb_sg_id = "${module.security-group.out_lb_sg_id}"
#   pub_subnet_2_id = "${module.vpc.out_pub_subnet_2_id}"
#   asg_max_size = "${var.asg_max_size}"
#   asg_min_size = "${var.asg_min_size}"
#   asg_health_check_gc = "${var.asg_health_check_gc}"
#   asg_health_check_type = "${var.asg_health_check_type}"
#   asg_desired_size = "${var.asg_desired_size}"
# }

# }

module "lambda" {
  source = "./modules/lambda" 
}
output "Nice_try" {
  value = "Keep it up"
  sensitive = false
}

module "label" {
  source    = "./modules/label"
  namespace = "demo"
  stage     = "demo"
  delimiter = "-"
}
# locals {
#   rds_credentials_mysql = {
#     username = var.docdb_username
#     password = var.docdb_password
#   }
#   rds_credentials_postgres = {
#     username = var.rds_credentials_global_postgres_username
#     password = var.rds_credentials_global_postgres_password
#   }
# }