resource "aws_s3_bucket" "prometheus" {
  count = var.prometheus_create_bucket ? 1 : 0

  bucket = "${var.cluster_name}-prometheus"
  tags   = var.tags
}

resource "helm_release" "prometheus" {
  count      = var.enabled ? 1 : 0
  name       = var.values.prometheus_name_addons
  repository = var.values.prometheus_repository_addons
  chart      = var.values.prometheus_chart_addons
  version    = var.values.prometheus_version_addons
  namespace  = var.namespace

  values = [
    templatefile("${path.module}/values.yaml", {
      alertmanager            = var.values.alertmanager
      server                  = var.values.prometheus_server
      additionalScrapeConfigs = var.values.prometheus_additionalScrapeConfigs
      alerting                = var.values.alerting
    })
  ]
}