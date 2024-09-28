resource "helm_release" "alb_ingress_controller" {
  count      = var.enabled ? 1 : 0
  name       = var.values.alb_name_addons
  repository = var.values.alb_repository_addons
  chart      = var.values.alb_chart_addons
  version    = var.values.alb_version_addons
  namespace  = var.namespace

  values = [
    yamlencode({
      replicaCount = var.values.replicaCount
      image = {
        repository = var.values.image.repository
        tag        = var.values.image.tag
      }
      resources = {
        requests = {
          memory = var.values.resources.memory_request
          cpu    = var.values.resources.cpu_request
        }
        limits = {
          memory = var.values.resources.memory_limit
          cpu    = var.values.resources.cpu_limit
        }
      }
      tolerations = var.values.tolerations
      affinity    = var.values.affinity
    })
  ]

}
