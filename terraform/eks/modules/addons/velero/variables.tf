variable "enabled" {
  description = "Enable or disable the Velero addon"
  type        = bool
}

variable "namespace" {
  description = "Namespace to deploy Velero"
  type        = string
}

variable "cluster_name" {
  type = string
}

variable "region" {
  type = string
}

variable "values" {
  description = "Consolidated values for Velero addon"
  type = object({
    velero_name_addons       = string
    velero_repository_addons = string
    velero_chart_addons      = string
    velero_version_addons    = string
    velero_create_bucket     = bool
    velero_server = object({
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
    configuration = object({
      provider = string
      backupStorageLocation = object({
        name   = string
        bucket = string
        config = object({
          region = string
        })
      })
    })
  })
}

variable "tags" {
  description = "Tags to apply to Velero resources"
  type        = map(string)
  default     = {}
}
