#Creating an EKS cluster with minimal options
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_private_access = var.cluster_endpoint_private_access
  cluster_endpoint_public_access  = var.cluster_endpoint_public_access

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  eks_managed_node_group_defaults = var.eks_managed_node_group_defaults
  eks_managed_node_groups = var.eks_managed_node_groups

  enable_irsa = true
  manage_aws_auth_configmap = true
  aws_auth_roles               = var.aws_auth_roles
  iam_role_additional_policies = {
    additional = aws_iam_policy.eks_additional_permission_policy.arn
  }
}