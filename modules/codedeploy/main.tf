# create a CodeDeploy application
resource "aws_codedeploy_app" "main" {
  name = var.app_name
}

# create a deployment group
resource "aws_codedeploy_deployment_group" "main" {
  app_name              = "${aws_codedeploy_app.main.name}"
  deployment_group_name = var.deployment_group_name
  service_role_arn      = var.service_role_arn

  deployment_config_name = "CodeDeployDefault.OneAtATime" # AWS defined deployment config
   ec2_tag_set {
    ec2_tag_filter {
      key   = var.key_ec2_tag_filter
      type  = "KEY_AND_VALUE"
      value = var.value_ec2_tag_filter
    }
   }
  # trigger a rollback on deployment failure event
  auto_rollback_configuration {
    enabled = false
    events = [
      "DEPLOYMENT_FAILURE",
    ]
  }
}