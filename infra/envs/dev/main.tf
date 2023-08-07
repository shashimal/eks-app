module "vpc" {
  source = "../../modules/vpc"

  env                = local.env
  name               = local.app_name
  azs                = ["ap-southeast-1a", "ap-southeast-1b"]
  cidr               = "20.0.0.0/16"
  private_subnets    = ["20.0.0.0/19", "20.0.32.0/19"]
  public_subnets     = ["20.0.64.0/19", "20.0.96.0/19"]
  database_subnets   = ["20.0.128.0/19", "20.0.160.0/19"]
  enable_nat_gateway = true
  single_nat_gateway = true
}

module "eks" {
  source = "../../modules/eks"

  cluster_name            = local.app_name
  vpc_id                  = module.vpc.vpc_id
  vpc_owner_id            = module.vpc.vpc_owner_id
  private_subnets         = module.vpc.private_subnets
  public_subnets          = module.vpc.public_subnets
  eks_managed_node_groups = local.eks_managed_node_groups
  aws_auth_roles          = local.aws_auth_roles
  zone_id = module.route53_zones.zone_ids["sms.duleendra.com"]
}

module "db" {
  source = "../../modules/rds"

  identifier            = local.app_name
  instance_class        = "db.t2.micro"
  vpc_cidr              = module.vpc.vpc_cidr
  vpc_id                = module.vpc.vpc_id
  database_subnet_group = module.vpc.database_subnet_group
}

module "frontend_app" {
  source = "../../modules/static-website"

  providers = {
    aws.us-east-1 = aws.us-east-1
  }

  app_name    = local.app_name
  bucket_name = "${local.app_name}-fronend-app"

  website = {
    index_document = "index.html"
    error_document = "index.html"
  }

  domain_name               = local.domain_name
  aliases                   = ["sms.duleendra.com"]
  subject_alternative_names = []
  zone_id                   = module.route53_zones.zone_ids["sms.duleendra.com"]
  depends_on = [module.route53_zones]
}

module "route53_zones" {
  source    = "../../modules/route53/zones"
  zones_map = local.route53_zones
}

module "route53_cloudfront" {
  source = "../../modules/route53/records"

  zone_name = module.route53_zones.zone_name["sms.duleendra.com"]
  records   = [
    {
      name = ""
      type = "A"
      alias = {
        name    = module.frontend_app.cloudfront_distribution_domain_name
        zone_id = module.frontend_app.cloudfront_distribution_hosted_zone_id
      }
    },
  ]
  depends_on = [module.route53_zones]
}

#module "route53_eks_alb" {
#  source = "../../modules/route53/records"
#
#  zone_name = module.route53_zones.zone_name["sms.duleendra.com"]
#  records   = [
#    {
#      name = "api.sms.duleendra.com"
#      type = "A"
#      alias = {
#        name    = "k8s-default-students-db89d4414f-847217679.ap-southeast-1.elb.amazonaws.com"
#        zone_id = "Z08101352708GUIAGOXL0"
#      }
#    },
#  ]
#  depends_on = [module.route53_zones]
#}


module "github_actions" {
  source = "../../modules/gha"

  app_name    = local.app_name
  github_repo = "shashimal/eks-app"
}

output "s" {
  value = module.route53_zones.zone_name
}