variable "namespace" {
  description = "Namespace to deploy the loki addon"
  type        = string
}

variable "enabled" {
  description = "Enable or disable the loki addon"
  type        = bool
}

variable "values" {
  description = "Consolidated values for loki addon"
  type = object({
    loki_name_addons       = string
    loki_repository_addons = string
    loki_chart_addons      = string
    loki_version_addons    = string
    replicaCount           = number
    image = object({
      repository = string
      tag        = string
    })
    retention = object({
      enabled = bool
      days    = number
    })
    ingress = object({
      enabled    = bool
      host       = string
      secretName = string
    })
    resources = object({
      memory_request = string
      cpu_request    = string
      memory_limit   = string
      cpu_limit      = string
    })
  })
}
