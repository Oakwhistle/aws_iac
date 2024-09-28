variable "namespace" {
  description = "Namespace to deploy the grafana addon"
  type        = string
}

variable "enabled" {
  description = "Enable or disable the grafana addon"
  type        = bool
}


variable "values" {
  description = "Consolidated values for grafana addon"
  type = object({
    grafana_name_addons       = string
    grafana_repository_addons = string
    grafana_chart_addons      = string
    grafana_version_addons    = string
    grafana_create_bucket     = bool
    replicaCount              = number
    adminUser                 = string
    adminPassword             = string
    service_type              = string
    persistence = object({
      storageClassName = string
      accessModes      = list(string)
      size             = string
    })
    image = object({
      repository = string
      tag        = string
    })
    resources = object({
      memory_request = string
      cpu_request    = string
      memory_limit   = string
      cpu_limit      = string
    })
    securityContext = object({
      runAsUser = number
      fsGroup   = number
    })
    tolerations = list(map(string))
    affinity    = map(any)
  })
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}
