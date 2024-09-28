resource "aws_s3_bucket" "velero" {
  count  = var.values.velero_create_bucket ? 1 : 0
  bucket = "${var.cluster_name}-velero"
  tags   = var.tags
}

resource "helm_release" "velero" {
  count      = var.enabled ? 1 : 0
  name       = var.values.velero_name_addons
  repository = var.values.velero_repository_addons
  chart      = var.values.velero_chart_addons
  version    = var.values.velero_version_addons
  namespace  = var.namespace

  values = [
    templatefile("${path.module}/values.yaml", {
      server        = var.values.velero_server
      configuration = var.values.configuration
    })
  ]
}
