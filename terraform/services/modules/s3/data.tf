data "aws_s3_bucket" "target_bucket" {
  for_each   = toset(local.list_target_bucket_logging)
  bucket     = each.value
  depends_on = [aws_s3_bucket.s3]
}
data "external" "s3_buckets" {
  program = ["bash", "${path.module}/scripts_bash/list_s3_buckets.sh", "${var.account_id}"]
}