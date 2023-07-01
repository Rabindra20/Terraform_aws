locals {
  ecr_lifecycle_policy = {
    rules = [
      {
        rulePriority = 1
        description  = "Expire images older than 14 days"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 14
        }
        action = {
          type = "expire"
        }
      }
    ]
  }
}

##########################################################################################
# ECR Repository and LifeCycle Policy for Demo
##########################################################################################
resource "aws_ecr_repository" "demo" {
  name = "demo"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = module.label.tags
}

resource "aws_ecr_lifecycle_policy" "demo" {
  policy     = jsonencode(local.ecr_lifecycle_policy)
  repository = aws_ecr_repository.demo.name
}

