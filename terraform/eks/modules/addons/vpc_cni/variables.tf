variable "namespace" {
  description = "Namespace to deploy the vpc_cni addon"
  type        = string
}

variable "enabled" {
  description = "Enable or disable the vpc_cni addon"
  type        = bool
}

variable "values" {
  description = "Consolidated values for vpc_cni addon"
  type = object({
    vpc_cni_name_addons       = string
    vpc_cni_repository_addons = string
    vpc_cni_chart_addons      = string
    vpc_cni_version_addons    = string
    image = object({
      repository = string
      tag        = string
    })
    cni_loglevel       = string
    custom_network_cfg = bool
    eni_config_label   = string
    eni_mtu            = string
    external_snat      = bool
    veth_prefix        = string
    plugin_log_file    = string
    initContainer_image = object({
      repository = string
      tag        = string
    })
    warm_ip_target   = number
    warm_enis_target = number
    resources        = map(any)
    tolerations      = list(map(string))
    affinity         = map(any)
  })
}
