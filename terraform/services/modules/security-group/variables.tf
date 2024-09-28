variable "name_prefix" {
  type    = string
  default = null
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "vpc_id" {
  description = "The VPC ID"
  type        = string
}
variable "security_groups" {
  description = "Map of security group definitions"
  type = map(object({
    name        = string
    description = optional(string)
    vpc_name    = optional(string)
    ingress = map(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      description = optional(string)
    }))
    egress = map(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_blocks = list(string)
      description = optional(string)
    }))
  }))
  default = {}
}
