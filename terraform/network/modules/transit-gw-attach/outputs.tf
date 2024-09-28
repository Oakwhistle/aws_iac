output "transit_gateway_attachment_ids" {
  description = "IDs of the Transit Gateway Attachments"
  value       = { for k, v in aws_ec2_transit_gateway_vpc_attachment.transit_gateway_attachment : k => v.id }
}