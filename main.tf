# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 3.0"
#     }
#   }
#   required_version = ">= 0.14.9"
# }

# Configure the AWS Provider
provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
  # for sso role in aws
  token = ""
}
# resource "aws_s3_bucket" "b" {
#   bucket = "rabindra"
#   acl    = "private"

#   tags = {
#     Name = "My bucket"
#   }
# }
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "rab"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "rab"
  }
}

resource "aws_subnet" "mysub1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet1"
  }
}
resource "aws_subnet" "mysub2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = "10.0.11.0/24"

  tags = {
    Name = "subnet2"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.myvpc.id

  route = []

  tags = {
    Name = "rt"
  }
}

resource "aws_route" "r" {
  route_table_id         = aws_route_table.rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_route_table.rt]
}


resource "aws_route_table_association" "a1" {
  subnet_id      = aws_subnet.mysub1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "a2" {
  subnet_id      = aws_subnet.mysub2.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "sg" {
  name        = "allow all traffic"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.myvpc.id

  ingress {
    description      = "all traffic"
    from_port        = 0    #All port
    to_port          = 0    #All port
    protocol         = "-1" #All traffic
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = null
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "All traffic"
  }
}
resource "aws_instance" "ec2-a" {
  ami           = "ami-0ed9277fb7eb570c9"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.mysub1.id

  tags = {
    Name = "rab-a"
  }
}

resource "aws_instance" "ec2-b" {
  ami           = "ami-0ed9277fb7eb570c9"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.mysub2.id

  tags = {
    Name = "rab-b"
  }
}