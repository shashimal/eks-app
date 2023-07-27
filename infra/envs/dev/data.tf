data "aws_iam_policy_document" "allow_eks_iam_policy" {
  statement {
    sid     = "AllowEKSDescribePermission"
    effect  = "Allow"
    actions = [
      "eks:DescribeCluster"
    ]
    resources = ["*"]
  }
}