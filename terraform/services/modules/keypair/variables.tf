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
  default = "eu-central-1"
}
variable "keypairs" {
  description = "Map of keypair definitions"
  type = map(object({
    name = string
    tags = optional(map(string))
  }))
  default = {}
}

variable "environment" {
  type = string
}

