resource "aws_iam_policy" "eks_additional_permission_policy" {
  name = "eks-additional-permission-policies"
  policy = data.aws_iam_policy_document.eks_additional_policy_document.json
}