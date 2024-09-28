variable "name_prefix" {
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

variable "subnets" {
  type    = map(string)
  default = {}
}

variable "msk-clusters" {
  description = "Map of MSK cluster configurations."
  type = map(object({
    name                   = optional(string)
    kafka_version          = optional(string)
    number_of_broker_nodes = optional(number)
    instance_type          = optional(string)
    ebs_volume_size        = optional(number)
    # subnets                = optional(list(string))
    # security_groups        = optional(list(string))
    subnets         = optional(string)
    security_groups = optional(string)
    tags            = optional(map(string))
    enable_iam_auth = optional(bool)

  }))
  default = {}
}
