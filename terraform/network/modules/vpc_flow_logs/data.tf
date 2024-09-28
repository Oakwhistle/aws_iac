# data "aws_region" "current" {}
# data "aws_vpcs" "vpc_id" {
#   count = each.value.vpc_name != null ? 1 : 0
#   filter {
#     name   = "tag:Name"
#     values = ["*${each.value.vpc_name}*"]
#     # values = ["*${var.vpc_name}*"]
#   }
# }
# data "vpc_name" "name" {
#   vpc_name = string
# }
# data "aws_vpcs" "vpc_id" {
#     for_each = var.vpc_flow_logs
#     filter {
#       name   = "tag:Name"
#       values = ["*${each.value.vpc_name}*"]
#     }
#     # for_each = toset(var.vpc_flow_logs[*])
#     # filter {
#     #   name   = "tag:Name"
#     #   values = ["*${each.value.vpc_name}*"]
#     # }
# }