variable "namespace" {
  description = "Namespace to deploy the alb ingress controller addon"
  type        = string
}

variable "enabled" {
  description = "Enable or disable the alb ingress controller addon"
  type        = bool
}

variable "values" {
  description = "Consolidated values for alb ingress controller addon"
  type = object({
    alb_name_addons       = string
    alb_repository_addons = string
    alb_chart_addons      = string
    alb_version_addons    = string
    replicaCount          = number
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
