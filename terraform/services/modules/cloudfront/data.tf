# data "aws_acm_certificate" "certificate" {
#   for_each = { for domain in flatten([for d in var.cloudfront : d.value.domain]) : domain => domain }

#   domain     = each.value
#   #statuses    = ["ISSUED"]
#   most_recent = true
# }