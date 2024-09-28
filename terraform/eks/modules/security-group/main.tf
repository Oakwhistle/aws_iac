data "aws_security_group" "existing_sg" {
  filter {
    name   = "group-name"
    values = ["AWDPY3P-SHARED-SERVICES-SG"]
  }

  vpc_id = var.vpc_id
}

resource "aws_security_group" "security_group" {
  count = length(data.aws_security_group.existing_sg.id) == 0 ? 1 : 0

  name        = "AWDPY3P-SHARED-SERVICES-SG"
  description = "Shared services security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}
