# locals {
#     short_to_full_bucket_name = {
#     for full_name in keys(var.buckets) : split("-", full_name)[1] => full_name
#   }
# }