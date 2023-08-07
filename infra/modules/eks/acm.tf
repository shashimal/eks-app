module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  create_certificate = true
  domain_name  = "sms.duleendra.com"
  zone_id      = var.zone_id
  subject_alternative_names = ["*.sms.duleendra.com"]
  validate_certificate = true
  wait_for_validation = false
  create_route53_records = true
}