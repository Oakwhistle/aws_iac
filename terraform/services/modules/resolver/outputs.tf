# output "resolvers" {
#   value = {
#     inbound = {
#       for key, value in aws_route53_resolver_endpoint.inbound : key => value.id
#     }
#     # outbound = {
#     #   for key, value in aws_route53_resolver_endpoint.outbound : key => value.id
#     # }
#   }
# }
