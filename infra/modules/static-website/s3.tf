module "s3" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~>3.14"

  bucket                   = var.bucket_name
  control_object_ownership = var.control_object_ownership
  object_ownership         = var.object_ownership
  cors_rule                = {
    cors_rule = {
      allowed_headers = ["*"]
      allowed_methods = ["PUT", "POST", "GET", "DELETE"]
      allowed_origins = ["*"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    }
  }

  block_public_acls = true
  restrict_public_buckets = false
  ignore_public_acls = true
  block_public_policy = false

  website = var.website
}

resource "aws_s3_bucket_policy" "cloudfront_bucket_policy" {
  bucket = module.s3.s3_bucket_id
  policy = data.aws_iam_policy_document.cloudfront_bucket_policy_document.json
  depends_on = [
    module.s3,
    module.cloudfront
  ]
}