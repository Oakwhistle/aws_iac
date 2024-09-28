variable "namespace" {
  description = "Namespace to deploy the kube_proxy addon"
  type        = string
}

variable "enabled" {
  description = "Enable or disable the kube_proxy addon"
  type        = bool
}

variable "values" {
  description = "Consolidated values for kube_proxy addon"
  type = object({
    kube_proxy_name_addons       = string
    kube_proxy_repository_addons = string
    kube_proxy_chart_addons      = string
    kube_proxy_version_addons    = string
    image = object({
      repository = string
      tag        = string
    })
    iptablesSyncPeriod = string
    conntrack = object({
      maxPerCore            = number
      min                   = number
      tcpTimeoutEstablished = string
      tcpTimeoutCloseWait   = string
    })
    resources = object({
      memory_request = string
      cpu_request    = string
      memory_limit   = string
      cpu_limit      = string
    })
  })
}
