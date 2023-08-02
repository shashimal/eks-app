resource "aws_iam_policy" "eks_additional_permission_policy" {
  name = "eks-additional-permission-policies"
  policy = data.aws_iam_policy_document.eks_additional_policy_document.json
}
#
module "secret_manger_irsa_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
  version = "~>5.15"

  role_name = "secret-manager-role"

  role_policy_arns = {
    policy = aws_iam_policy.secret_manager_access.arn
  }

  oidc_providers = {
    ex = {
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["default:secret-manager-role"]
    }
  }
}

resource "aws_iam_policy" "secret_manager_access" {
  name = "secret-manager-access"
  policy = data.aws_iam_policy_document.secret_manager_access_policy_document.json
}

resource "kubernetes_service_account" "iam_secret_manager_access" {
  metadata {
    name      = "secret-manager-role"
    namespace = "default"
    annotations = {
      "eks.amazonaws.com/role-arn" = module.secret_manger_irsa_role.iam_role_arn
    }
  }
}
