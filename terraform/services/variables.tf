variable "account_id" {
  type = string
}
variable "region" {
  type = string
}
variable "business" {
  type = string
}
variable "environment" {
  type = string
}
variable "accountable" {
  type = string
}
variable "service" {
  type = string
}
variable "project" {
  type = string
}
variable "vpc_name" {
  type    = string
  default = ""
}
variable "vpc_id" {
  type    = string
  default = ""
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
variable "inbound_resolvers" {
  description = "Map of inbound resolvers"
  type = map(object({
    name                 = string
    security_group_names = list(string)
    ip_addresses = map(object({
      subnet_name = string
      ip_address  = optional(string, null)
    }))
    tags = optional(map(string))
  }))
  default = {}
}
variable "outbound_resolvers" {
  description = "Map of outbound resolvers"
  type = map(object({
    name                 = string
    security_group_names = list(string)
    ip_addresses = map(object({
      subnet_name = string
      ip_address  = optional(string, null)
    }))
    routes = map(object({
      domain_name     = string
      destination_ips = map(string)
      tags            = optional(map(string))
    }))
    tags = optional(map(string))
  }))
  default = {}
}

variable "ec2_instances" {
  description = "Mapa de configuraciones para las instancias"
  type = map(object({
    name                = string
    role                = string
    ami                 = string
    instance_type       = string
    security_groups     = optional(list(string))
    subnet_type         = optional(string)
    subnet_name         = optional(string)
    az                  = optional(string)
    subnet_id           = optional(string, null)
    key_pair            = optional(string)
    security_group_name = optional(string)
    user_data           = optional(string)
    service_ip          = optional(string)
    management_ip       = optional(string)
    volume_size         = optional(number)
    volume_type         = optional(string, "gp3")
    iops                = optional(number)
    schedule            = optional(string)
    enable_metadata     = optional(bool, false)
    tags                = optional(map(string))
    opt_disk            = optional(number)
    swap_disk           = optional(number)
    temp_disk           = optional(number)
    paging_disk         = optional(number)
    data_disk           = optional(number)
    logs_disk           = optional(number)
  }))
  default = {}
}

variable "keypairs" {
  description = "Map of keypair definitions"
  type = map(object({
    name = string
    tags = optional(map(string))
  }))
  default = {}
}
variable "s3" {
  description = "Define a list of buckets"
  type = map(object({
    bucket_name   = string
    role          = optional(string, "storage")
    versioning    = optional(string, "Disabled")
    force_destroy = optional(bool, false)
    website_configuration = optional(object({
      index_document = string
      error_document = string
    }))
    cors_configuration = optional(object({
      allowed_headers = list(string)
      allowed_methods = list(string)
      allowed_origins = list(string)
      expose_headers  = list(string)
      max_age_seconds = number
    }), null)
    logging_configuration = optional(object({
      target_bucket_for_logging = optional(string)
      prefix                    = string
    }), null)
    # lifecycle_configuration_rules = optional(map(object({
    #   id_name = string
    #   status  = string
    #   filter = optional(map(object({
    #     prefix                   = string
    #     tags                     = map(string)
    #     object_size_greater_than = number
    #     object_size_less_than    = number
    #   })), null)
    #   transition_storage_class = optional(map(object({
    #     type_transition  = string
    #     value_transition = number
    #     storage_class    = string
    #   })), null)
    #   expiration = optional(map(object({
    #     days                         = number
    #     date                         = string
    #     expired_object_delete_marker = bool
    #   })), null)
    #   noncurrent_version_transition = optional(map(object({
    #     newer_noncurrent_versions = number
    #     noncurrent_days           = number
    #     storage_class             = string
    #   })), null)
    #   noncurrent_version_expiration = optional(object({
    #     newer_noncurrent_versions = number
    #     noncurrent_days           = number
    #   }), null)
    # })), null)
    bucket_acl = optional(object({
      object_ownership        = optional(string, null)
      block_public_acls       = optional(bool, null)
      block_public_policy     = optional(bool, null)
      ignore_public_acls      = optional(bool, null)
      restrict_public_buckets = optional(bool, null)
      type_acl                = optional(string, "private")
    }), null)
  }))
  default = {}
}

variable "cloudfront" {
  description = "List of CloudFront distributions with their settings"
  type = map(object({
    name                     = string
    bucket_name              = string
    enabled                  = optional(bool, true)
    is_ipv6_enabled          = optional(bool, true)
    comment                  = optional(string, "")
    default_root_object      = optional(string, "index.html")
    default_ttl              = optional(number, 3600)
    max_ttl                  = optional(number, 86400)
    minimum_protocol_version = optional(string, "TLSv1.2_2021")
    ordered_cache_behaviors = optional(list(object({
      path_pattern    = string
      allowed_methods = list(string)
      cached_methods  = list(string)
      forwarded_values = object({
        query_string = bool
        cookies = object({
          forward = string
        })
      })
      min_ttl     = optional(number, 0)
      default_ttl = optional(number, 3600)
      max_ttl     = optional(number, 86400)
    })), [])
    alternate_domain_names = optional(list(string), [])
    domain                 = optional(string, "")
  }))
  default = {}
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
