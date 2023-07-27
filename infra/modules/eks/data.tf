data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "eks_additional_policy_document" {
  statement {
    sid = "ECRPermission"
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetAuthorizationToken"
    ]
    resources = ["*"]
  }
}
