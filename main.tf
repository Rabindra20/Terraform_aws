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
}
resource "aws_s3_bucket" "b" {
  bucket = "rabindra"
  acl    = "private"

  tags = {
    Name = "My bucket"
  }
}