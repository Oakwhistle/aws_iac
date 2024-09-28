locals {
  # List targets buckets for logging
  list_target_bucket_logging = flatten([
    for bucket_item in var.s3_data :
    ["${var.name_prefix}-${bucket_item.logging_configuration.target_bucket_for_logging}"]
    if bucket_item.logging_configuration != null
  ])
}
locals {
  existing_buckets = data.external.s3_buckets.result
}
