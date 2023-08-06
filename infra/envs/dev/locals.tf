locals {

  app_name = "sms"
  env = "dev"
  domain_name = "sms.duleendra.com"
  subject_alternative_names = [
    "api.sms.duleendra.com"
  ]


  eks_managed_node_groups = {
    general = {
      desired_size = 2
      min_size     = 1
      max_size     = 2

      labels = {
        role = "general"
      }

      instance_types = ["t2.small"]
      capacity_type  = "ON_DEMAND"
    }
  }

  eks_managed_node_group_defaults = {
    disk_size = 20
  }

  aws_auth_roles = [
    {
      rolearn  = module.eks_admins_iam_role.iam_role_arn
      username = module.eks_admins_iam_role.iam_role_name
      groups   = ["system:masters"]
    },
  ]

  route53_zones = {
    "sms.duleendra.com" = {
      comment = "sms.duleendra.com"
      tags = {
        env = "production"
      }
    }
  }
}