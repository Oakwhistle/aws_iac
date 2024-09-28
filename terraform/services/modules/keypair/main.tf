resource "aws_key_pair" "keypair" {
  for_each   = var.keypairs
  key_name   = "${var.name_prefix}${each.value.name}"
  public_key = tls_private_key.keypair[each.key].public_key_openssh
  tags = merge(
    {
      Name = "${var.name_prefix}${each.value.name}"
    },
  var.tags)
}

resource "tls_private_key" "keypair" {
  for_each  = var.keypairs
  algorithm = "RSA"
  rsa_bits  = 4096

}

resource "aws_ssm_parameter" "parameter" {
  for_each = var.keypairs
  name     = "/${var.environment}/EC2/${each.value.name}"
  type     = "SecureString"
  value    = tls_private_key.keypair[each.key].private_key_pem
  tags = merge(
    {
      Name = "${var.name_prefix}${each.value.name}"
    },
  var.tags)
}