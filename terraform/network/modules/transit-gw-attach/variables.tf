variable "name_prefix" {
  type    = string
  default = null
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "vpc_ids" {
  type    = map(string)
  default = {}
}
variable "subnet_ids" {
  type    = map(string)
  default = {}
}
variable "region" {
  type = string
}
variable "transit_gateway_id" {
  type    = string
  default = null
}
variable "transit_gateway_attachments" {
  type = map(object({
    name         = string
    vpc_name     = string
    subnet_names = list(string)
    tags         = optional(map(string))
  }))
  default = {}
}
