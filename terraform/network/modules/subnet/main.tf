resource "aws_subnet" "subnet" {
  for_each = var.subnets

  vpc_id            = var.vpc_ids[each.value.vpc_name]
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-${each.value.name}"
    }
  )
  lifecycle {
    ignore_changes = [ tags ]
  }
}

resource "aws_network_acl_association" "subnet_network_acl" {
  for_each = var.subnets

  subnet_id      = aws_subnet.subnet[each.key].id
  network_acl_id = var.network_acl_ids[each.value.network_acl_name]
}