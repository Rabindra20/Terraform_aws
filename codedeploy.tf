# data "aws_iam_role" "codedeploy" {
#   name               = "codedeployrole"
# }
# module "codedeploy" {
#   source                  = "./modules/codedeploy"
#   app_name="demo"
#   deployment_group_name="dev"
#   service_role_arn=data.aws_iam_role.codedeploy.arn
#   key_ec2_tag_filter="Name"
#   value_ec2_tag_filter="demo"
# }