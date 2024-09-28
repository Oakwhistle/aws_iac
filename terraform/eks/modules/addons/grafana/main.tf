resource "aws_s3_bucket" "grafana" {
  count  = var.values.grafana_create_bucket ? 1 : 0
  bucket = "${var.cluster_name}-grafana"
  tags   = var.tags
}

resource "helm_release" "grafana" {
  count      = var.enabled ? 1 : 0
  name       = var.values.grafana_name_addons
  repository = var.values.grafana_repository_addons
  chart      = var.values.grafana_chart_addons
  version    = var.values.grafana_version_addons
  namespace  = var.namespace

  values = [templatefile("${path.module}/values.yaml", {
    replicaCount    = var.values.replicaCount
    image           = var.values.image
    persistence     = var.values.persistence
    securityContext = var.values.securityContext
    tolerations     = var.values.tolerations
    affinity        = var.values.affinity
    resources       = var.values.resources
    adminUser       = var.values.adminUser
    adminPassword   = var.values.adminPassword
    service_type    = var.values.service_type
  })]

}
