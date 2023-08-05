data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    sid    = "ReadS3Objects"
    effect = "Allow"
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject",]
    resources = [
      module.s3.s3_bucket_arn,
      "${module.s3.s3_bucket_arn}/*"
    ]
  }
}

data "aws_iam_policy_document" "cloudfront_bucket_policy_document" {
  statement {
    sid = "PolicyForCloudFrontPrivateContent"
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions = ["s3:GetObject"]
    resources = ["${module.s3.s3_bucket_arn}/*"]
    condition {
      test     = "StringEquals"
      values   = [module.cloudfront.cloudfront_distribution_arn]
      variable = "AWS:SourceArn"
    }
  }
}