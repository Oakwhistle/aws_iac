resource "aws_iam_role" "FTGHA_role" {
  name = "${var.name_prefix}-FTGHA-Role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = ["ec2.amazonaws.com",
          "ssm.amazonaws.com"]
        }
      }
    ]
  })
}

resource "aws_iam_policy" "FTGHA_policy" {
  name        = "FTGHA_policy"
  description = "Policy to allow specific FortiGate nodes actions"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
          "ec2:AssociateAddress",
          "ec2:AssignPrivateIpAddresses",
          "ec2:UnassignPrivateIpAddresses",
          "ec2:ReplaceRoute"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.FTGHA_role.name
}

resource "aws_iam_role_policy_attachment" "ssm_patch_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMPatchAssociation"
  role       = aws_iam_role.FTGHA_role.name
}

resource "aws_iam_role_policy_attachment" "FTGHA_policy" {
  policy_arn = aws_iam_policy.FTGHA_policy.arn
  role       = aws_iam_role.FTGHA_role.name
}


resource "aws_iam_instance_profile" "ssm_profile" {
  name = "${var.name_prefix}-FTGHA-instance_profile"
  role = aws_iam_role.FTGHA_role.name
}