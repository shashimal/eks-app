module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  providers = {
    aws = aws.us-east-1
  }


  create_certificate = true
  domain_name  = var.domain_name
  zone_id      = var.zone_id
  subject_alternative_names = var.subject_alternative_names
  validate_certificate = true
  wait_for_validation = var.wait_for_validation
  create_route53_records = true
  tags = var.tags
}