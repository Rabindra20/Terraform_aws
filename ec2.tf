# data "aws_iam_role" "ec2" {
#   name               = ""
# }
data "aws_caller_identity" "current" {}

locals {
  ami_id     = "ami-0fcf52bcf5db7b003"
  account_id = data.aws_caller_identity.current.account_id
  ec2_name   = "nn" 
  ec2_security_group_name = "sg-ec2"
}
##########################################################################################
# Create EC2
##########################################################################################
# module "ec2" {
#   source                  = "./modules/ec2"
#   ec2_instance_name       = join(module.label.delimiter, [local.ec2_name])
#   ec2_instance_type       = "t2.micro"
#   ami_id                  = local.ami_id
#   ec2_security_group_name = join(module.label.delimiter, [local.ec2_name, 1])
#   vpc_id                  = data.aws_vpc.dev.id
#   subnet_id               = 
#   key_name                = aws_key_pair.default.id
#   ec2_role                = data.aws_iam_role.ec2.name
#   is_bastion              = true
#    userdata                = file("${path.module}/start-master.sh")
# #   image_owners            = local.account_id
#   ec2_cidr_blocks         = [""]
# }

resource "tls_private_key" "ec2" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "default" {
  key_name   = local.ec2_name
  public_key = tls_private_key.ec2.public_key_openssh
}