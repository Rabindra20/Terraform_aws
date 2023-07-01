variable "name" {
    type = string
}

variable "strategy" {
    type = string
    default = "cluster"
}
variable "asg_name" {
    type = string
}
variable "max_size" {
    type = number
}
variable "min_size" {
    type = number
}
variable "desired_capacity" {
    type = number
}
variable "vpc_zone_identifier" {
    type = set(string)
}
variable "delete_time" {
  type = string
}
variable "lifecycle_name" {
    type = string
}
variable "default_instance_warmup" {
  type = string
}
variable "launch_template_name" {
    type = string
}
variable "image_id" {
    type = string
}
variable "instance_type" {
    type = string
}
variable "key_name" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "security_groups" {
  type = set(string)
}
variable "volume_size" {
    type = string
}
variable "userdata" {
    type = string
}
variable "tags" {
    type = map(string)
}
variable "value" {
    type = string
}
variable "target_group_arns" {
  type = set(string)
}
variable "iam_instance_profile" {
    type = string
    description = "(optional) describe your variable"
}
