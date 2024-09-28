// AWS VPC 
resource "aws_vpc" "fgtvm-vpc" {
  cidr_block           = var.vpccidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = merge(
    {
      Name = "${var.name_prefix}-SEC-NET-VPC"
    },
  var.tags)
}

resource "aws_subnet" "publicsubnetaz1" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.publiccidraz1
  availability_zone = "${var.region}${var.az1}"
  tags = merge(
    {
      Name = "${var.name_prefix}-SEC-PUBLIC-FGT1-A"
    },
  var.tags)
}

resource "aws_subnet" "publicsubnetaz2" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.publiccidraz2
  availability_zone = "${var.region}${var.az2}"
  tags = merge(
    {
      Name = "${var.name_prefix}-SEC-PUBLIC-FGT2-B"
    },
  var.tags)
}


resource "aws_subnet" "privatesubnetaz1" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.privatecidraz1
  availability_zone = "${var.region}${var.az1}"
  tags = merge(
    {
      Name = "${var.name_prefix}-SEC-PRIVATE-FGT1-A"
    },
  var.tags)
}

resource "aws_subnet" "privatesubnetaz2" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.privatecidraz2
  availability_zone = "${var.region}${var.az2}"
  tags = merge(
    {
      Name = "${var.name_prefix}-SEC-PRIVATE-FGT2-B"
    },
  var.tags)
}

resource "aws_subnet" "hasyncsubnetaz1" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.hasynccidraz1
  availability_zone = "${var.region}${var.az1}"
  tags = merge(
    {
      Name = "${var.name_prefix}-SEC-HASYNC-FGT1-A"
    },
  var.tags)
}

resource "aws_subnet" "hasyncsubnetaz2" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.hasynccidraz2
  availability_zone = "${var.region}${var.az2}"
  tags = merge(
    {
      Name = "${var.name_prefix}-SEC-HASYNC-FGT2-B"
    },
  var.tags)
}

resource "aws_subnet" "hamgmtsubnetaz1" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.hamgmtcidraz1
  availability_zone = "${var.region}${var.az1}"
  tags = merge(
    {
      Name = "${var.name_prefix}-SEC-HAMGMT-FGT1-A"
    },
  var.tags)
}

resource "aws_subnet" "hamgmtsubnetaz2" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.hamgmtcidraz2
  availability_zone = "${var.region}${var.az2}"
  tags = merge(
    {
      Name = "${var.name_prefix}-SEC-HAMGMT-FGT2-B"
    },
  var.tags)
}

resource "aws_subnet" "transitsubnetaz1" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.transitcidraz1
  availability_zone = "${var.region}${var.az1}"
  tags = merge(
    {
      Name = "${var.name_prefix}-SEC-TRANSIT-FGT1-A"
    },
  var.tags)
}

resource "aws_subnet" "transitsubnetaz2" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.transitcidraz2
  availability_zone = "${var.region}${var.az2}"
  tags = merge(
    {
      Name = "${var.name_prefix}-SEC-TRANSIT-FGT2-B"
    },
  var.tags)
}