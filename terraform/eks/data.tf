data "aws_vpcs" "vpc_id" {
  filter {
    name   = "tag:Name"
    values = ["*${var.eks_config.vpc.vpc_name}*"]
  }
}

data "aws_subnets" "filtered_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpcs.vpc_id.ids[0]]
  }

  filter {
    name   = "tag:Name"
    values = var.eks_config.vpc.subnet_names
  }
}

data "aws_subnet" "subnet_details" {
  for_each = toset(data.aws_subnets.filtered_subnets.ids)
  id       = each.key
}