data "aws_vpcs" "vpc_id" {
  filter {
    name   = "tag:Name"
    values = ["*${var.vpc_name}*"]
  }
}
data "aws_subnets" "subnet_ids" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.vpc_id.ids[0]]
  }
}

data "aws_subnet" "subnet_ids" {
  for_each = toset(data.aws_subnets.subnet_ids.ids)

  id = each.value
}

data "aws_security_groups" "security_group_ids" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.vpc_id.ids[0]]
  }
}

data "aws_security_group" "security_group_ids" {
  for_each = toset(data.aws_security_groups.security_group_ids.ids)

  id = each.value
}
