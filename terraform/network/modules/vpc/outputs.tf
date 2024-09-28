output "vpc_ids" {
  value = { for k, v in aws_vpc.vpc : k => v.id }
}