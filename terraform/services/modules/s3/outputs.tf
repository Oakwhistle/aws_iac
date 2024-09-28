output "new_buckets" {
  description = "A map of bucket names to their ARNs"
  value       = { for k, v in aws_s3_bucket.s3 : v.bucket => v.arn }
}
# Salida para verificar los ARNs generados
output "existing_buckets" {
  value = local.existing_buckets
  }