resource "aws_s3_bucket" "karpenter" {
  count = var.values.karpenter_create_bucket ? 1 : 0

  bucket = "${var.cluster_name}-karpenter"
  tags   = var.tags
}

resource "helm_release" "karpenter" {
  count      = var.enabled ? 1 : 0
  name       = var.values.karpenter_name_addons
  repository = var.values.karpenter_repository_addons
  chart      = var.values.karpenter_chart_addons
  version    = var.values.karpenter_version_addons
  namespace  = var.namespace

  values = [
    templatefile("${path.module}/values.yaml", {
      replicaCount = var.values.replicaCount
      image        = var.values.image
      scaling      = var.values.scaling
      metrics      = var.values.metrics
      resources    = var.values.resources
      tolerations  = var.values.tolerations
      affinity     = var.values.affinity
    })
  ]
}
