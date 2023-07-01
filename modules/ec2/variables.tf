variable "ec2_security_group_name" {
  type = string
}

variable "ec2_security_group_description" {
  type    = string
  default = "EC2 Security Group Managed By Terraform"
}

variable "vpc_id" {
  type = string
}

variable "ec2_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "subnet_id" {
  type = string
}


variable "ec2_cidr_blocks" {
  type = list(string)
#   default = ["" ]
}

variable "image_filter_values" {
  type    = list(string)
  default = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
}

variable "virtualization_filter_values" {
  type    = list(string)
  default = ["hvm"]
}

variable "tags" {
  type = map(string)
  default = {
    Name    = "SCH"
    Project = "SCh"
  }
}

variable "ec2_instance_name" {
  type = string
}

variable "ec2_volume_size" {
  type    = string
  default = 30
}

variable "ami_id" {
  type    = string
  default = "ami-0fcf52bcf5db7b003"
}

variable "key_name" {
  type = string
}

variable "is_bastion" {
  type    = bool
  default = false
}

variable "userdata" {
  type    = string
  default = ""
}

variable "ebs_optimized" {
  type    = bool
  default = false
}
variable "ec2_role" {
  type = string
}