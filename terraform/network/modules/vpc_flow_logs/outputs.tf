output "flow_log_ids" {
  value = { for k, v in aws_flow_log.local : k => v.id }
}
# output "data" {
#   value = data.aws_vpcs.vpc_id[0]
# }