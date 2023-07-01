
output "public_dns" {
  value = aws_instance.ec2.public_dns
}

output "public_ip" {
  value = aws_instance.ec2.public_ip
  # value = aws_eip.elastic_ip.public_ip
}

output "ec2_arn" {
  value = aws_instance.ec2.arn
}

output "private_ip" {
  value = aws_instance.ec2.private_ip
}

# output "ec2_role_arn" {
#   value = data.aws_iam_role.ec2.arn
# }

output "ec2_id" {
  value = aws_instance.ec2.id
}