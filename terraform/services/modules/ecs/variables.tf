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
variable "environment" {
  type = string
}
variable "project" {
  type = string
}
variable "service" {
  type = string
}
variable "subnets" {
  type    = map(string)
  default = {}
}

variable "keypairs" {
  type    = map(string)
  default = {}
}

