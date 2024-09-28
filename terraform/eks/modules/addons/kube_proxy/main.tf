resource "helm_release" "kube_proxy" {
  count      = var.enabled ? 1 : 0
  name       = var.values.kube_proxy_name_addons
  repository = var.values.kube_proxy_repository_addons
  chart      = var.values.kube_proxy_chart_addons
  version    = var.values.kube_proxy_version_addons
  namespace  = var.namespace

  values = [
    templatefile("${path.module}/values.yaml", {
      image              = var.values.image
      iptablesSyncPeriod = var.values.iptablesSyncPeriod
      conntrack          = var.values.conntrack
      resources          = var.values.resources
    })
  ]
}
