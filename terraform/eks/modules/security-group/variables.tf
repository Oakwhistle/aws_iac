
variable "name_prefix" {
  description = "Prefix for security group names"
  type        = string
}

variable "tags" {
  description = "Tags to add to resources"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "ID of the VPC"
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
    tags = optional(map(string))
  }))
  default = {}
}
