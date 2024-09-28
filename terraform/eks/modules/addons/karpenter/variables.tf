variable "namespace" {
  description = "Namespace to deploy the karpenter addon"
  type        = string
}

variable "enabled" {
  description = "Enable or disable the karpenter addon"
  type        = bool
}

variable "values" {
  description = "Consolidated values for karpenter addon"
  type = object({
    karpenter_name_addons       = string
    karpenter_repository_addons = string
    karpenter_chart_addons      = string
    karpenter_version_addons    = string
    karpenter_create_bucket     = bool
    replicaCount                = number
    image = object({
      repository = string
      tag        = string
    })
    scaling = object({
      enabled     = bool
      minReplicas = number
      maxReplicas = number
    })
    metrics = object({
      enabled = bool
      port    = number
    })
    resources = object({
      memory_request = string
      cpu_request    = string
      memory_limit   = string
      cpu_limit      = string
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
