resource "aws_vpc" "vpc" {
  for_each = var.vpcs

  cidr_block           = each.value.cidr_block
  instance_tenancy     = each.value.instance_tenancy
  enable_dns_support   = each.value.enable_dns_support
  enable_dns_hostnames = each.value.enable_dns_hostnames
  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-${each.value.name}"
    }
  )
}

# resource "aws_flow_log" "local" {
#   count             = var.enable_flow_logs != false ? 1 : 0
#   for_each          = var.vpcs
#   iam_role_arn      = aws_iam_role.local_flow_log_role[each.key].arn
#   log_destination   = aws_cloudwatch_log_group.local_flow_logs[each.key].arn
#   traffic_type      = "ALL"
#   vpc_id            = aws_vpc.vpc.id
#   tags = merge(
#     var.tags,
#     {
#       Name = "${var.name_prefix}-${each.value.name}"
#     }
#   )
#   depends_on = [ aws_vpc.vpc, each.value.enable_flow_logs ]
# }

# resource "aws_cloudwatch_log_group" "local_flow_logs" {
#   for_each          = var.vpcs
#   name              = "vpc-flow-logs/${var.name_prefix}-${each.value.name}"
#   retention_in_days = 30
#   depends_on = [ aws_vpc.vpc, each.value.enable_flow_logs ]
# }

# resource "aws_iam_role" "local_flow_log_role" {
#   for_each = var.vpcs
#   name     = "flow-logs-policy-${each.value.name}"

#   assume_role_policy = <<EOF
#     {
#       "Version": "2012-10-17",
#       "Statement": [
#         {
#           "Sid": "",
#           "Effect": "Allow",
#           "Principal": {
#             "Service": "vpc-flow-logs.amazonaws.com"
#           },
#           "Action": "sts:AssumeRole"
#         }
#       ]
#     }
#     EOF

#   depends_on = [ aws_flow_log.local ]
# }

# resource "aws_iam_role_policy" "logs_permissions" {
#   for_each = var.vpcs
#   name     = "flow-logs-policy-${each.value.name}"
#   role     = aws_iam_role.local_flow_log_role[each.key].id

#   policy = <<EOF
#   {
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Action": [
#           "logs:CreateLogGroup",
#           "logs:CreateLogStream",
#           "logs:PutLogEvents",
#           "logs:DescribeLogGroups",
#           "logs:DescribeLogStreams",
#           "logs:CreateLogDelivery",
#           "logs:DeleteLogDelivery"
#         ],
#         "Effect": "Allow",
#         "Resource": "arn:aws:logs:${var.region}:*:log-group:vpc-flow-logs*"
#       }
#     ]
#   }
#   EOF

#   depends_on = [ aws_vpc.vpc, each.value.enable_flow_logs ]
# }