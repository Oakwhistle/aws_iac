data "aws_vpcs" "vpc_id" {
  count = var.vpc_name != null ? 1 : 0
  filter {
    name   = "tag:Name"
    values = ["*${var.vpc_name}*"]
  }
}