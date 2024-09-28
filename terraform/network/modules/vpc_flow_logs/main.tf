resource "aws_flow_log" "local" {
  for_each        = var.vpc_flow_logs
  iam_role_arn    = aws_iam_role.local_flow_log_role[each.key].arn
  log_destination = aws_cloudwatch_log_group.local_flow_logs[each.key].arn
  traffic_type    = "ALL"
  vpc_id          = can(var.existin_vpc_name) && var.existin_vpc_name != "" ? var.existin_vpc_name : can(var.vpc_ids[each.value.vpc_name]) ? var.vpc_ids[each.value.vpc_name] : null
  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-${each.value.vpc_name}"
    }
  )
}

resource "aws_cloudwatch_log_group" "local_flow_logs" {
  for_each          = var.vpc_flow_logs
  name              = "vpc-flow-logs/${var.name_prefix}-${each.value.vpc_name}"
  retention_in_days = 30
}

resource "aws_iam_role" "local_flow_log_role" {
  for_each           = var.vpc_flow_logs
  name               = "flow-logs-policy-${each.value.vpc_name}"
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Sid": "",
        "Effect": "Allow",
        "Principal": {
          "Service": "vpc-flow-logs.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  }
  EOF
}

resource "aws_iam_role_policy" "logs_permissions" {
  for_each = var.vpc_flow_logs
#   for_each = var.vpcs
  name     = "flow-logs-policy-${each.value.vpc_name}"
  role     = aws_iam_role.local_flow_log_role[each.key].id

  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogGroups",
          "logs:DescribeLogStreams",
          "logs:CreateLogDelivery",
          "logs:DeleteLogDelivery"
        ],
        "Effect": "Allow",
        "Resource": "arn:aws:logs:${var.region}:*:log-group:vpc-flow-logs*"
      }
    ]
  }
  EOF
}
