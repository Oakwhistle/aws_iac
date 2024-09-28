resource "helm_release" "loki" {
  count      = var.enabled ? 1 : 0
  name       = var.values.loki_name_addons
  repository = var.values.loki_repository_addons
  chart      = var.values.loki_chart_addons
  version    = var.values.loki_version_addons
  namespace  = var.namespace

  values = [
    templatefile("${path.module}/values.yaml", {
      replicaCount = var.values.replicaCount
      image        = var.values.image
      retention    = var.values.retention
      ingress      = var.values.ingress
      resources    = var.values.resources
    })
  ]
}
