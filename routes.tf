locals {
  #  Public routes
  backend_domains_dev = {
    demo_domain    = "example.com"
  }
}
##########################################################################################
# Public Route53 Records
##########################################################################################
resource "aws_route53_record" "demo" {
  name    = local.demo
  type    = "CNAME"
  records = [module.uv-app.cloudfront_domain]
  zone_id = data.aws_route53_zone.demo.id
  ttl     = 60
}

resource "aws_route53_record" "backend" {
  for_each = local.backend_domains_dev
  name     = each.value
  type     = "CNAME"
  records  = [module.dev-lb.alb_dns_name]
  zone_id  = data.aws_route53_zone.demo.id
  ttl      = 60
}