variable "enabled" {
  description = "Enable or disable the Prometheus addon"
  type        = bool
}

variable "namespace" {
  description = "Namespace to deploy the Prometheus addon"
  type        = string
}

variable "prometheus_create_bucket" {
  description = "Boolean to decide whether to create an S3 bucket for Prometheus"
  type        = bool
}

variable "additionalScrapeConfigs" {
  description = "Additional scrape configurations"
  type = list(object({
    job_name = string
    static_configs = list(object({
      targets = list(string)
    }))
  }))
}



variable "values" {
  description = "Consolidated values for Prometheus addon"
  type = object({
    prometheus_name_addons       = string
    prometheus_repository_addons = string
    prometheus_chart_addons      = string
    prometheus_version_addons    = string
    alertmanager = object({
      enabled      = bool
      replicaCount = number
      image = object({
        repository = string
        tag        = string
      })
    })
    prometheus_server = object({
      replicaCount = number
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
      persistentVolume = object({
        enabled      = bool
        size         = string
        storageClass = string
        accessModes  = list(string)
        mountPath    = string
      })
    })
  })
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

# Centralización de cluster_name, region y account_id desde el nivel superior
variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}
