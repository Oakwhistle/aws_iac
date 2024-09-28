resource "aws_sqs_queue" "sqs_queue" {
  for_each                   = var.sqs_queue
  name                       = "${var.name_prefix}-${each.value.name}-sqs-queue"
  delay_seconds              = each.value.delay_seconds
  max_message_size           = each.value.max_message_size
  message_retention_seconds  = each.value.message_retention_seconds
  receive_wait_time_seconds  = each.value.receive_wait_time_seconds
  visibility_timeout_seconds = each.value.visibility_timeout_seconds
  policy = jsonencode({
    "Version" : "2008-10-17",
    "Id" : "__default_policy_ID",
    "Statement" : [
      {
        "Sid" : "__owner_statement",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        "Action" : "SQS:*",
        "Resource" : "arn:aws:sqs:us-east-1:${data.aws_caller_identity.current.account_id}:${var.name_prefix}-${each.value.name}-sqs-queue"
      }
    ]
  })
  tags = {
    Accountable = "${var.tags["Accountable"]}"
    Deploy      = "${var.tags["Deploy"]}"
    Business    = "${var.tags["Business"]}"
    Environment = "${var.tags["Environment"]}"
    Service     = "${var.tags["Service"]}"
    Name        = "${var.name_prefix}-${each.value.name}-sqs-queue"
  }
  lifecycle {
    ignore_changes = [
      policy,
    ]
  }
}

data "aws_caller_identity" "current" {}