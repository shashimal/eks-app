module "secrets-store-csi" {
  source  = "SPHTech-Platform/secrets-store-csi/aws"
  version = "1.0.1"

  cluster_name         = module.eks.cluster_name
  oidc_provider_arn    = module.eks.oidc_provider_arn
  namespace            = "kube-system"
  syncSecretEnabled    = true
  enableSecretRotation = true
}
