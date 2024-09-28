variable "name_prefix" {
  type    = string
  default = null
}
variable "vpc_id" {
  type    = string
  default = null
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "security_groups" {
  type    = map(string)
  default = {}
}

variable "subnet_ids" {
  type    = map(string)
  default = {}
}

variable "inbound_resolvers" {
  description = "Map of inbound resolvers"
  type = map(object({
    name                 = string
    security_group_names = list(string)
    ip_addresses = map(object({
      subnet_name = string
      ip_address  = optional(string, null)
    }))
    tags = map(string)
  }))
}

variable "outbound_resolvers" {
  description = "Map of outbound resolvers"
  type = map(object({
    name                 = string
    security_group_names = list(string)
    ip_addresses = map(object({
      subnet_name = string
      ip_address  = optional(string, null)
    }))
    routes = map(object({
      domain_name     = string
      destination_ips = map(string)
      tags            = optional(map(string))
    }))
    tags = optional(map(string))
  }))
  default = {}
}
