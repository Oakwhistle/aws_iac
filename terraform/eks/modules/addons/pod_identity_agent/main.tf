resource "helm_release" "pod_identity_agent" {
  count      = var.enabled ? 1 : 0
  name       = var.values.pod_identity_agent_name_addons
  repository = var.values.pod_identity_agent_repository_addons
  chart      = var.values.pod_identity_agent_chart_addons
  version    = var.values.pod_identity_agent_version_addons
  namespace  = var.namespace

  values = [
    templatefile("${path.module}/values.yaml", {
      replicaCount   = var.values.replicaCount
      image          = var.values.image
      webhook        = var.values.webhook
      identityConfig = var.values.identityConfig
      resources      = var.values.resources
    })
  ]
}
