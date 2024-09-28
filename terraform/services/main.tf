module "security_groups" {
  source          = "./modules/security-group"
  name_prefix     = local.name_prefix
  tags            = local.tags
  vpc_id          = local.vpc_id
  security_groups = var.security_groups
}
module "resolver_endpoints" {
  source             = "./modules/resolver"
  inbound_resolvers  = var.inbound_resolvers
  outbound_resolvers = var.outbound_resolvers
  name_prefix        = local.name_prefix
  tags               = local.tags
  vpc_id             = local.vpc_id
  security_groups    = local.security_groups
  subnet_ids         = local.subnets
}

module "keypairs" {
  source      = "./modules/keypair"
  region      = var.region
  keypairs    = var.keypairs
  name_prefix = local.name_prefix
  tags        = local.tags
  environment = var.environment
}

module "ec2" {
  source          = "./modules/ec2"
  count           = length(var.ec2_instances) > 0 ? 1 : 0
  name_prefix     = local.name_prefix
  environment     = var.environment
  tags            = local.tags
  vpc_id          = local.vpc_id
  security_groups = local.security_groups
  subnets         = local.subnets
  instances       = var.ec2_instances
  project         = var.project
  service         = var.service
}
module "s3" {
  source      = "./modules/s3"
  s3_data     = var.s3
  s3_tags     = local.tags
  region      = var.region
  account_id  = var.account_id
  name_prefix = lower(local.name_prefix)
}

module "cloudfront" {
  source      = "./modules/cloudfront"
  count       = length(var.cloudfront) > 0 ? 1 : 0
  name_prefix = local.name_prefix
  environment = var.environment
  tags        = local.tags
  cloudfront  = var.cloudfront
  project     = var.project
  service     = var.service
  region      = var.region
  # buckets     = local.all_buckets
}

module "rds" {
  source          = "./modules/rds"
  count           = length(var.rds_instances) > 0 ? 1 : 0
  name_prefix     = local.name_prefix
  tags            = local.tags
  rds_instances   = var.rds_instances
  security_groups = local.security_groups
  environment     = var.environment
}

module "msk_cluster" {
  source = "./modules/msk" # Ruta al módulo
  count  = length(var.msk-clusters) > 0 ? 1 : 0
  name_prefix     = local.name_prefix
  security_groups = local.security_groups
  subnets         = local.subnets
  environment     = var.environment
  tags            = local.tags
  msk-clusters = var.msk-clusters
}
