variable "vpc_ids" {
  type = map(string)
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
  type        = string
  default     = "eu-central-1"
  description = "AWS region in which resources will get deployed. Defaults to Ireland."
}
variable "dhcp_option_sets" {
  type = map(object({
    name        = string
    domain_name = string
    vpc_name    = string
    tags        = optional(map(string))
  }))
  default = {}
}
