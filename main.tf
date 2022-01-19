# provider "aws" {
#   region     = "us-east-1"
#   access_key = ""
#   secret_key = ""
#   # for sso role in aws
#   token = ""
# }
module "vpc" {
  source = "./modules/vpc"

  # aws_region = "${var.aws_region}"
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

##s3 bucket

# module "s3" {
#   #path to reusable code of modules
#   source = "./modules/s3"
#   bucket_name = var.my_s3_bucket
#   tags = var.my_s3_tags
# }
# # Upload an object
# resource "aws_s3_bucket_object" "object" {

# # If you want to upload all the files of a directory, then you need to use 'for_each' loop
#   for_each = fileset("F:/Git/6_aws_cloud-amit-sparsha-aashishgautam/serverless-rabindra/5.CI/build/", "**")
#   bucket = module.s3.name
#   key    = each.value
#   acl    = "public-read" 
#   source = "F:/Git/6_aws_cloud-amit-sparsha-aashishgautam/serverless-rabindra/5.CI/build/${each.value}"
#   etag = filemd5("F:/Git/6_aws_cloud-amit-sparsha-aashishgautam/serverless-rabindra/5.CI/build/${each.value}")
# }

output "Nice_try" {
  value = "Keep it up"
  sensitive = false
}