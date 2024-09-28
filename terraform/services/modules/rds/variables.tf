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

variable "rds_instances" {
  description = "Map of RDS instances to create"
  type = map(object({
    name                                  = optional(string)
    allocated_storage                     = optional(number)
    max_allocated_storage                 = optional(number)
    storage_type                          = optional(string)
    engine                                = optional(string)
    engine_version                        = optional(string)
    instance_class                        = optional(string)
    db_name                               = optional(string)
    username                              = optional(string)
    password                              = optional(string)
    security_group_names                  = optional(list(string), [])
    publicly_accessible                   = optional(bool)
    skip_final_snapshot                   = optional(bool, true)
    performance_insights_retention_period = optional(number)
    performance_insights_enabled          = optional(bool)
    storage_encrypted                     = optional(bool)
    allow_major_version_upgrade           = optional(bool)
    auto_minor_version_upgrade            = optional(bool)
    deletion_protection                   = optional(bool, false)
    tags                                  = optional(map(string))
  }))
  default = {}
}
