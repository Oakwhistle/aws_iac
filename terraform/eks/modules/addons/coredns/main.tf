resource "helm_release" "coredns" {
  count      = var.enabled ? 1 : 0
  name       = var.values.coredns_name_addons
  repository = var.values.coredns_repository_addons
  chart      = var.values.coredns_chart_addons
  version    = var.values.coredns_version_addons
  namespace  = var.namespace

  values = [templatefile("${path.module}/values.yaml", {
    replicaCount = var.values.replicaCount
    image        = var.values.image
    resources    = var.values.resources
    tolerations  = var.values.tolerations
    affinity     = var.values.affinity
  })]

}
