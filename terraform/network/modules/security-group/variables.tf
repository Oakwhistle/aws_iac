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
variable "existin_vpc_name"  {
  type = string
  default = null
}
variable "security_groups" {
  description = "Map of security group definitions"
  type = map(object({
    name        = string
    description = optional(string)
    vpc_name    = string
    ingress = optional(map(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      description = optional(string)
    })), {})
    egress = optional(map(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      description = optional(string)
    })), {})
  }))
  default = {}
}