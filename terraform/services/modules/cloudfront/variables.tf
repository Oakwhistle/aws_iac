variable "name_prefix" {
  type    = string
  default = null
}
variable "tags" {
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
variable "region" {
  type = string
}
variable "buckets" {
  type    = map(string)
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
    domain = optional(string, "")
  }))
  default = {}
}
