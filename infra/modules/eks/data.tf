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

data "aws_iam_policy_document" "secret_manager_access_policy_document" {
  statement {
    sid = "SecretMangerPermission"
    effect = "Allow"
    actions = [
      "secretsmanager:*"
    ]
    resources = ["*"]
  }
}
