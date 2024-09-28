variable "account_id" {
  type = string
}
variable "s3_tags" {
  description = "Tags for S3 bucket resources"
  type        = map(string)
  default     = {}
}
variable "region" {
  type    = string
  default = ""
}
variable "name_prefix" {
  type    = string
  default = null
}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "s3_data" {
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
