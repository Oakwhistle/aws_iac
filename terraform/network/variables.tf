variable "account_id" {
  type = string
}
variable "region" {
  type        = string
  default     = "eu-central-1"
  description = "AWS region in which resources will get deployed. Defaults to Ireland."
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
  default = null
}
variable "existin_vpc_name" {
  type    = string
  default = null
}

variable "enable_rds_subnet_group" {
  type = bool
  default = true
}

variable "subnets" {
  type = map(object({
    cidr_block        = string
    availability_zone = string
    vpc_name          = string
    name              = string
    network_acl_name  = string
    tags              = optional(map(string))
  }))
  default = {}
}
variable "vpcs" {
  description = "Map of VPC configurations"
  type = map(object({
    name                 = string
    cidr_block           = string
    instance_tenancy     = optional(string, "default")
    enable_dns_support   = optional(bool, true)
    enable_dns_hostnames = optional(bool, true)
    tags                 = optional(map(string))
  }))
  default = {}
}
variable "network_acls" {
  description = "Map of network ACLs with their rules"
  type = map(object({
    name     = string
    vpc_name = string
    tags     = optional(map(string))
    rules = map(object({
      rule_number = number
      type        = string
      protocol    = string
      rule_action = string
      cidr_block  = string
      from_port   = number
      to_port     = number
    }))
  }))
  default = {}
}
variable "dhcp_option_sets" {
  type = map(object({
    name        = string
    domain_name = string
    vpc_name    = string
    tags        = optional(map(string))
  }))
  default = {}
}
variable "internet_gateways" {
  type = map(object({
    name     = string
    vpc_name = string
    tags     = optional(map(string))
  }))
  default = {}
}
variable "nat_gateways" {
  type = map(object({
    name                 = string
    subnet_name          = string
    connectivity_type    = string
    eip_allocation_id    = optional(string)
    primary_private_ipv4 = optional(string)
    tags                 = optional(map(string))
  }))
  default = {}
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
    tags = optional(map(string))
  }))
  default = {}
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
variable "subnet_route_tables" {
  type = map(object({
    name          = string
    vpc_name      = string
    subnets_names = list(string)
    tags          = optional(map(string))
    routes = map(object({
      destiny = string
      target  = string
    }))
  }))
  default = {}
}
variable "vpc_flow_logs" {
  description = "Map of VPC configurations"
  type = map(object({
    vpc_name             = string
    enable_flow_logs     = optional(bool, false)
    tags                 = optional(map(string))
  }))
  default = {}
}
variable "transit_gateways" {
  description = "Map of transit gateways to create"
  type = map(object({
    name                            = string
    description                     = optional(string, null)
    amazon_side_asn                 = optional(number, 64512)
    auto_accept_shared_attachments  = optional(string, "enable")
    default_route_table_association = optional(string, "disable")
    default_route_table_propagation = optional(string, "disable")
    vpn_ecmp_support                = optional(string, "enable")
    dns_support                     = optional(string, "enable")
    multicast_support               = optional(string, "disable")
    tags                            = map(string)
  }))
  default = {}
}

variable "transit_gateway_route_tables" {
  description = "Map of transit gateway route tables to create"
  type = map(object({
    name                 = string
    transit_gateway_name = string
    tags                 = map(string)
  }))
  default = {}
}

variable "forti-gate-ha" {
  description = "Configuration for FortiGate HA setup"
  type = object({
    az1             = string
    az2             = string
    vpccidr         = string
    publiccidraz1   = string
    privatecidraz1  = string
    hasynccidraz1   = string
    hamgmtcidraz1   = string
    transitcidraz1 = string
    publiccidraz2   = string
    privatecidraz2  = string
    hasynccidraz2   = string
    hamgmtcidraz2   = string
    transitcidraz2  = string
    license_type    = string
    license_format  = string
    arch            = string
    size            = string
    adminsport      = string
    keypair_name    = string
    activeports = map(object({
      ip      = string
      mask    = string
      gateway = string
    }))
    passiveports = map(object({
      ip      = string
      mask    = string
      gateway = string
    }))
    bootstrap_active  = string
    bootstrap_passive = string
    license           = string
    license2          = string
  })
  default = {
    az1             = ""
    az2             = ""
    vpccidr         = ""
    publiccidraz1   = ""
    privatecidraz1  = ""
    hasynccidraz1   = ""
    hamgmtcidraz1   = ""
    transitcidraz1 = ""
    publiccidraz2   = ""
    privatecidraz2  = ""
    hasynccidraz2   = ""
    hamgmtcidraz2   = ""
    transitcidraz2  = ""
    license_type    = ""
    license_format  = ""
    arch            = ""
    size            = ""
    adminsport      = ""
    keypair_name    = ""
    activeports = {
      activeport1 = {
        ip      = ""
        mask    = ""
        gateway = ""
      }
      activeport2 = {
        ip      = ""
        mask    = ""
        gateway = ""
      }
      activeport3 = {
        ip      = ""
        mask    = ""
        gateway = ""
      }
      activeport4 = {
        ip      = ""
        mask    = ""
        gateway = ""
      }
    }
    passiveports = {
      passiveport1 = {
        ip      = ""
        mask    = ""
        gateway = ""
      }
      passiveport2 = {
        ip      = ""
        mask    = ""
        gateway = ""
      }
      passiveport3 = {
        ip      = ""
        mask    = ""
        gateway = ""
      }
      passiveport4 = {
        ip      = ""
        mask    = ""
        gateway = ""
      }
    }
    bootstrap_active  = ""
    bootstrap_passive = ""
    license           = ""
    license2          = ""
  }
}
