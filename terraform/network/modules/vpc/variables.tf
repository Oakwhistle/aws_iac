variable "vpcs" {
  description = "Map of VPC configurations"
  type = map(object({
    name                 = string
    cidr_block           = string
    instance_tenancy     = optional(string, "default")
    enable_dns_support   = optional(bool, true)
    enable_dns_hostnames = optional(bool, true)
    tags                 = optional(map(string))
    enable_flow_logs     = optional(bool, false)
  }))
  default = {}
}
variable "name_prefix" {
  type    = string
  default = null
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "region" {
  type    = string
  default = null
}