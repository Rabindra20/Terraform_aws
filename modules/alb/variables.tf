variable "public_subnets" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "alb_security_group_name" {
  type = string
}

variable "alb_security_group_description" {
  type    = string
  default = "controls access to the ALB"
}

variable "alb_name" {
  type = string
}

variable "alb_target_name" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {
  }
}

variable "aws_acm_certificate_arn" {
  type = string
}

variable "ssl_policy" {
  type    = string
  default = "ELBSecurityPolicy-FS-1-1-2019-08"
}

variable "idle_timeout" {
  type    = number
  default = 300
}

variable "project" {
  type    = string
  default = "supercare"
}