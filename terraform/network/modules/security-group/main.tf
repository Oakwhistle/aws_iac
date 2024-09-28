resource "aws_security_group" "security_group" {
  for_each = var.security_groups

  name        = "${var.name_prefix}-${each.value.name}"
  description = each.value.description
  vpc_id      = can(var.existin_vpc_name) && var.existin_vpc_name != "" ? var.existin_vpc_name : can(var.vpc_ids[each.value.vpc_name]) ? var.vpc_ids[each.value.vpc_name] : null
  tags = merge(
    var.tags,
    {
      Name = "${var.name_prefix}-${each.value.name}"
    }
  )
  dynamic "ingress" {
    for_each = each.value.ingress
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

  dynamic "egress" {
    for_each = each.value.egress
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
      description = egress.value.description
    }
  }
}
