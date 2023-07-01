module "dev-lb" {
  source                  = "./modules/alb"
  alb_name                = "demo-${module.label.stage}-lb"
  alb_security_group_name = "demo-${module.label.stage}-lb"
  alb_target_name         = "demo-${module.label.stage}-lb-default"
  aws_acm_certificate_arn = aws_acm_certificate.demo.arn
  public_subnets          = []
  vpc_id                  = hhh
}

##########################################################################################
# TargetGroup and Listener Rule for demo instance
##########################################################################################
resource "aws_alb_target_group" "instance" {
  vpc_id      = data.aws_vpc.dev.id
  name        = "demo-${module.label.stage}"
  target_type = "instance"
  protocol    = "HTTP"
  port        = 3000
  health_check {
    healthy_threshold   = "5"
    interval            = "60"
    protocol            = "HTTP"
    matcher             = "200-499"
    timeout             = "5"
    path                = "/"
    unhealthy_threshold = "2"
  }
}

resource "aws_alb_listener_rule" "instance" {
  listener_arn = module.dev-lb.listener_arn
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.instance.arn
  }
  condition {
    host_header {
      values = [local.backend_domains_dev.demo_domain]
    }
  }
}

##########################################################################################
# TargetGroup and Listener Rule for demo ip
##########################################################################################
resource "aws_alb_target_group" "ip" {
  vpc_id      = data.aws_vpc.dev.id
  name        = "demo-${module.label.stage}"
  target_type = "ip"
  protocol    = "HTTP"
  port        = 3000
  health_check {
    healthy_threshold   = "5"
    interval            = "60"
    protocol            = "HTTP"
    matcher             = "200-499"
    timeout             = "5"
    path                = "/"
    unhealthy_threshold = "2"
  }
}

resource "aws_alb_listener_rule" "ip" {
  listener_arn = module.dev-lb.listener_arn
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.ip.arn
  }
  condition {
    host_header {
      values = [local.backend_domains_dev.demo_domain]
    }
  }
}
