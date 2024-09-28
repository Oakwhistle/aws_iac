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
variable "internet_gateways" {
  type = map(object({
    name     = string
    vpc_name = string
    tags     = optional(map(string))
  }))
}