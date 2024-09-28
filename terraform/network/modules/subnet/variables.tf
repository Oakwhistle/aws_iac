variable "vpc_ids" {
  type    = map(string)
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
variable "network_acl_ids" {
  type    = map(string)
  default = {}
}

variable "subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
    tags              = optional(map(string))
    vpc_name          = string
    name              = string
    network_acl_name  = string
  }))
  default = {}
}
variable "vpcs" {
  description = "Map of VPC configurations"
  type = map(object({
    name                 = string
    cidr_block           = string
    instance_tenancy     = string
    enable_dns_support   = bool
    enable_dns_hostnames = bool
    tags                 = optional(map(string))
  }))
  default = {}
}