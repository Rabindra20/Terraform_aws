data "aws_ami" "latest_amazon_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-*-gp2"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }

  owners = ["amazon"]
}

# resource "aws_key_pair" "web_server_key" {
#   key_name = "web_server_key"
#   public_key = "${file("${var.key_pair_path}")}"
# }
resource "tls_private_key" "app-key" {
  algorithm   = "RSA"
}
resource "aws_key_pair" "app-instance-key" {
  key_name   = "app-key"
  public_key = tls_private_key.app-key.public_key_openssh
}

resource "local_file" "app-key" {
    content     = tls_private_key.app-key.private_key_pem
    filename = "app-key.pem"
}

locals {
  # staging_env = "staging"
  instance_name = "${terraform.workspace}-instance" 
}
#================ Instance ================
resource "aws_instance" "web_server" {
  ami = "${data.aws_ami.latest_amazon_ami.id}"
  instance_type = "${var.instance_type}"
  subnet_id = "${var.pub_subnet_1_id}"
  key_name = "app-key"
  # key_name = "${aws_key_pair.web_server_key.key_name}"
  # user_data = "${file("${var.user_data_path}")}"
  vpc_security_group_ids = ["${var.web_server_sg_id}"]

  tags = {
    # Name = "Web Server"
    # Name = "${local.staging_env}-ec2"
    Name = local.instance_name
  }
    # provisioner "file" {
#     source      = "file.txt"
#     destination = "file.txt"
# }
##local-exec
# provisioner "local-exec" {
#     command = "touch hello.txt"
# }
#remote
# provisioner "remote-exec" {
#     inline = [
#       "touch hello.txt",
#       "echo helloworld remote provisioner >> hello.txt",
#     ]
# }
# connection {
#       type        = "ssh"
#       host        = self.public_ip
#       private_key = file("app-key.pem")
#       user        = "ec2-user"
#       timeout     = "4m"
#    }
}