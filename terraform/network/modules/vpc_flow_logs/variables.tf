variable "vpcs" {
  description = "Map of VPC configurations"
  type = map(object({
    name                 = string
    cidr_block           = string
    enable_flow_logs     = optional(bool, false)
    instance_tenancy     = optional(string, "default")
    enable_dns_support   = optional(bool, true)
    enable_dns_hostnames = optional(bool, true)
    tags                 = optional(map(string))
  }))
  default = {}
}
variable "vpc_flow_logs" {
  description = "Map of VPC configurations"
  type = map(object({
    vpc_name             = string
    enable_flow_logs     = optional(bool, false)
    tags                 = optional(map(string))
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
variable "enable_flow_logs" {
  type    = bool
  default = false
}
variable "region" {
  type    = string
  default = null
}
variable "existin_vpc_name"  {
  type = string
  default = null
}
variable "vpc_ids" {
  type = map(string)
  default = {}
}
