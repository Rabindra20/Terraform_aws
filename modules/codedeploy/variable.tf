variable "app_name" {
    type = string
    description = "Code deploy app name"
}
variable "deployment_group_name" {
    type = string
    description = "Deployment group name"
}
variable "service_role_arn" {
  type = string
}
variable "key_ec2_tag_filter" {
  type = string
}
variable "value_ec2_tag_filter" {
  type = string
}