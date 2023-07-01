## Default Region
resource "aws_acm_certificate" "demo" {
  domain_name               = "demo.com"
  subject_alternative_names = ["*.demo.com"]
  validation_method         = "DNS"
  tags                      = module.label.tags
  # provider        = aws.nvirginia
}

resource "aws_route53_record" "demo" {
  for_each = {
    for dvo in aws_acm_certificate.demo.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.demo.zone_id
  # provider        = aws.nvirginia

}

resource "aws_acm_certificate_validation" "demo" {
  certificate_arn = aws_acm_certificate.demo.arn
  # provider        = aws.nvirginia
}

