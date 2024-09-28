module "eks_cluster" {
  source       = "./modules/eks"
  tags         = local.tags
  cluster_name = local.name_prefix
  visibility   = var.eks_config.visibility
  cluster_mode = var.eks_config.cluster_mode

  # VPC configuration
  vpc_subnet_ids = data.aws_subnets.filtered_subnets.ids
  vpc_name       = var.eks_config.vpc.vpc_name

  # Node group configuration
  node_group_name   = var.eks_config.node_group.node_group_name
  instance_type     = var.eks_config.node_group.instance_type
  node_count        = var.eks_config.node_group.node_count
  max_capacity      = var.eks_config.node_group.max_capacity
  min_capacity      = var.eks_config.node_group.min_capacity
  strategy          = var.eks_config.node_group.strategy
  alb_listener_http = var.eks_config.alb_listener_http
  alb_target_group  = var.eks_config.alb_target_group
}

module "coredns" {
  source    = "./modules/addons/coredns"
  enabled   = var.eks_config.addons.coredns.enabled
  namespace = var.eks_config.addons.coredns.namespace
  values    = var.eks_config.addons.coredns.values
}

module "grafana" {
  source       = "./modules/addons/grafana"
  enabled      = var.eks_config.addons.grafana.enabled
  namespace    = var.eks_config.addons.grafana.namespace
  values       = var.eks_config.addons.grafana.values
  tags         = local.tags
  cluster_name = local.name_prefix
}

module "karpenter" {
  source       = "./modules/addons/karpenter"
  enabled      = var.eks_config.addons.karpenter.enabled
  namespace    = var.eks_config.addons.karpenter.namespace
  values       = var.eks_config.addons.karpenter.values
  tags         = local.tags
  cluster_name = local.name_prefix
}

module "kube_proxy" {
  source    = "./modules/addons/kube_proxy"
  enabled   = var.eks_config.addons.kube_proxy.enabled
  namespace = var.eks_config.addons.kube_proxy.namespace
  values    = var.eks_config.addons.kube_proxy.values
}

module "loki" {
  source    = "./modules/addons/loki"
  enabled   = var.eks_config.addons.loki.enabled
  namespace = var.eks_config.addons.loki.namespace
  values    = var.eks_config.addons.loki.values
}



module "velero" {
  source       = "./modules/addons/velero"
  enabled      = var.eks_config.addons.velero.enabled
  namespace    = var.eks_config.addons.velero.namespace
  values       = var.eks_config.addons.velero.values
  cluster_name = local.name_prefix
  region       = var.region
  tags         = local.tags
}

module "vpc_cni" {
  source    = "./modules/addons/vpc_cni"
  enabled   = var.eks_config.addons.vpc_cni.enabled
  namespace = var.eks_config.addons.vpc_cni.namespace
  values    = var.eks_config.addons.vpc_cni.values
}

module "alb_ingress_controller" {
  source    = "./modules/addons/alb_ingress_controller"
  enabled   = var.eks_config.addons.alb_ingress_controller.enabled
  namespace = var.eks_config.addons.alb_ingress_controller.namespace
  values    = var.eks_config.addons.alb_ingress_controller.values
}

module "pod_identity_agent" {
  source    = "./modules/addons/pod_identity_agent"
  enabled   = var.eks_config.addons.pod_identity_agent.enabled
  namespace = var.eks_config.addons.pod_identity_agent.namespace
  values    = var.eks_config.addons.pod_identity_agent.values
}
