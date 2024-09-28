resource "helm_release" "vpc_cni" {
  count      = var.enabled ? 1 : 0
  name       = var.values.vpc_cni_name_addons
  repository = var.values.vpc_cni_repository_addons
  chart      = var.values.vpc_cni_chart_addons
  version    = var.values.vpc_cni_version_addons
  namespace  = var.namespace

  values = [
    templatefile("${path.module}/values.yaml", {
      cni_loglevel        = var.values.cni_loglevel
      custom_network_cfg  = var.values.custom_network_cfg
      eni_config_label    = var.values.eni_config_label
      eni_mtu             = var.values.eni_mtu
      external_snat       = var.values.external_snat
      veth_prefix         = var.values.veth_prefix
      plugin_log_file     = var.values.plugin_log_file
      initContainer_image = var.values.initContainer_image
      warm_ip_target      = var.values.warm_ip_target
      warm_enis_target    = var.values.warm_enis_target
      resources           = var.values.resources
      tolerations         = var.values.tolerations
      affinity            = var.values.affinity
    })
  ]
}
