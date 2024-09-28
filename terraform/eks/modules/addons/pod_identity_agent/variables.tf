variable "namespace" {
  description = "Namespace to deploy the Pod Identity Agent addon"
  type        = string
}

variable "enabled" {
  description = "Enable or disable the Pod Identity Agent addon"
  type        = bool
}

variable "values" {
  description = "Consolidated values for Pod Identity Agent addon"
  type = object({
    pod_identity_agent_name_addons       = string
    pod_identity_agent_repository_addons = string
    pod_identity_agent_chart_addons      = string
    pod_identity_agent_version_addons    = string
    replicaCount                         = number
    image = object({
      repository = string
      tag        = string
    })
    webhook = object({
      enabled     = bool
      serviceName = string
      namespace   = string
      port        = number
    })
    identityConfig = object({
      assumeRole = string
      awsRegion  = string
    })
    resources = object({
      memory_request = string
      cpu_request    = string
      memory_limit   = string
      cpu_limit      = string
    })
  })
}
