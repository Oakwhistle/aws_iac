variable "namespace" {
  description = "Namespace to deploy the coredns addon"
  type        = string
}

variable "enabled" {
  description = "Enable or disable the coredns addon"
  type        = bool
}

variable "values" {
  description = "Consolidated values for coredns addon"
  type = object({
    coredns_name_addons       = string
    coredns_repository_addons = string
    coredns_chart_addons      = string
    coredns_version_addons    = string
    replicaCount              = number
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
    tolerations = list(map(string))
    affinity    = map(any)
  })
}
