# provider "aws" {
#   region     = "us-east-1"
#   access_key = "ASIA52BEGI3BMIGT7URG"
#   secret_key = "/m4hZscvoU9+4oMlYk9d36EOkpC12EGsGi9WV0Ic"
#   # for sso role in aws
#   token = "IQoJb3JpZ2luX2VjEFUaCXVzLWVhc3QtMiJIMEYCIQD0h24Nt8Um7wu7J4IwU1lzp76Bk76ddtZ62KsYSG9h5QIhAK++5Khe/bBfbgsdcPtA5fGJ+rDKK8FGEkODHtq/5NrUKqIDCG4QABoMOTQ5MjYzNjgxMjE4Igz/ALyXq/qI6uJ5TcUq/wJZYn6K2/aei+omjMHQapXiVLSLdmfwWxD1uOSarejE6hCmIOuhDxzLorHvQ1FcFaeDlgsUdOwX1bBN/ythrHsj+IAmz7VWTXg+8QFEMwxG4WkZr/QFBqu89s6XO+o3DNa+fR60HPBT0ZwEVVgsdBuzyygobO5Zy3nNuo9CTrTJKRfrWp9Si9aBQY4VLjK/XiJYBbElRkoHzqlN84RTlr5LAC7R8qwKCHgBX/A8C4Y3uLvjMphy6q8V1o5QYygTcMdmg4xp5MSuSj5fkByTaDuJRer1DGzUAfsEdNAcvf4QwaTFJvhrua8DUwWqqvuYTc6ldxjJ5BnZXi7ET09NN1ods/uuJ2/trQUvCkkPfGuys67I5wNhPAVYn6BJ4WqYMEVGV7urlgioNoH/Y75dZa6nvNuqtPJYCaeONvgP1Ikg5IT7jK/xeQSFuA6SsGNWU9RA8OG3Uv2XGTnQA7fwFIt9VuAwfaOPB+adSemiV7gxfJZPF4NMOjsgA/IKn6NiTzCJ/IOPBjqlATEXN3Y3Yyf9q5d1u7/KeYhgd1wK0AOWqdiBZ88O17j99bRMFzLpLZMXpjbJICKJPdgjtT4Q2Zt9+ZXD44rDZHpltOXbBBUXHtFZrGPStDw1vKaUp/UhzH6OqwR3gSyOQi7jS0SSfz7SWuFp5r9UuzjeXNDljlLBpHfT/yqrD74btQ39rlX2UsSUOL+Fm8ogvqeSCty10lCkATYHmILxf3JYp6IfbQ=="
# }
module "vpc" {
  source = "./modules/vpc"

  aws_region = "${var.aws_region}"
}

module "securitygrp" {
  source = "./modules/securitygrp"

  vpc_id = "${module.vpc.out_vpc_id}"
  aws_region = "${var.aws_region}"
  vpc_cidr_block = "${module.vpc.out_vpc_cidr_block}"
}

module "ec2" {
  source = "./modules/ec2"

  # vpc_id = "${module.vpc.out_vpc_id}"
  aws_region = "${var.aws_region}"
  # key_pair_path = "${var.key_pair_path}"
  instance_type = "${var.instance_type}"
  pub_subnet_1_id = "${module.vpc.out_pub_subnet_1_id}"
  #  iam_instance_profile_name = "${module.iam.out_iam_instance_profile_name}"
  #  user_data_path = "${var.user_data_path}"
  web_server_sg_id = "${module.securitygrp.out_web_server_sg_id}"
}
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
