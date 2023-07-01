resource "aws_ecs_cluster" "demo" {
  name = "demo"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

#########################################
# task definition & service for demo
#########################################
module "uv_api_dev" {
  source                  = "./modules/ecs"
  app_name                ="demo-${module.label.stage}"
  cluster                 = aws_ecs_cluster.demo.id
  task_definition         = "demo-${module.label.stage}-task"
  launch_type             = "FARGATE"
  scheduling_strategy     = "REPLICA"
  desired_count           = 1
  force_new_deployment    = true
  subnets                 = []
  assign_public_ip        = false
  security_groups         = [data.aws_security_group.sg-all.id]
  target_group            = aws_alb_target_group.demo.arn
  container_port          = 3000
  tags                    = module.label.tags
  task_definition_name    ="demo-${module.label.stage}"
  stage                   =module.label.stage
  ecr_repo                =aws_ecr_repository.demo.repository_url
  ecr_image_tag           ="test"
  aws_region              ="us-west-2"
  hostPort                =3000
  protocol                ="tcp"
  memory                  = "1024"
  cpu                     = "512"
  networkMode             ="awsvpc"
  requires_compatibilities=["FARGATE"]
  task_role_arn=aws_iam_role.task_definition.arn
  execution_role_arn=aws_iam_role.task_definition.arn
  depends_on               = [aws_iam_role.task_definition]
}
#########################################
# task definition role
#########################################
resource "aws_iam_role" "task_definition" {
  name               = "ECS-Task-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = merge({
    Name = "task-definition"
  }, module.label.tags)
}


resource "aws_iam_role_policy_attachment" "AmazonECSTaskExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.task_definition.name
  depends_on = [aws_iam_role.task_definition]
}