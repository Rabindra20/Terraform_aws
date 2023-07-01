module "asg" {

  source                  = "./modules/asg"
  name                    = "demo"
  strategy                = "partition"
  asg_name                = "demo"
  max_size                = 2
  min_size                = 1
  desired_capacity        = 1
  vpc_zone_identifier     = [data.aws_subnet.jj.id]
  delete_time             = "15m"
  lifecycle_name          = "demo"
  default_instance_warmup = "2"
  launch_template_name    = "demo-template"
  image_id                = local.ami_id
  instance_type           = "t2.micro"
  key_name                =aws_key_pair.default.id
  security_groups         = [data.aws_security_group.sg-all.id]
  subnet_id               =  jjjj
  volume_size             = 20
  userdata                = "${base64encode(file("${path.module}/start-master.sh"))}"
  tags                    = module.label.tags
  value                   = "demo"
  iam_instance_profile    = data.aws_iam_role.ec2.name
  target_group_arns       = [aws_alb_target_group.demo.arn]
}
