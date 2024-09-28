resource "aws_s3_bucket" "s3" {
  for_each = var.s3_data
  bucket = "${var.name_prefix}-${each.value.bucket_name}"
  force_destroy = each.value.force_destroy

  tags = merge(var.s3_tags,
    {
      "Name" = "${var.name_prefix}-${each.value.bucket_name}",
      "Role" = "${each.value.role}"
    })
}

 resource "aws_s3_bucket_versioning" "versioning" {
   for_each = var.s3_data
   bucket = aws_s3_bucket.s3[each.key].id
   versioning_configuration {
     status = each.value.versioning
   }
   depends_on = [aws_s3_bucket.s3]
 }

resource "aws_s3_bucket_website_configuration" "website_configuration" {
  for_each = { for k, v in var.s3_data : k => v if v.website_configuration != null }
  bucket = aws_s3_bucket.s3[each.key].id
  index_document {
    suffix = each.value.website_configuration.index_document
  }
  error_document {
    key = each.value.website_configuration.error_document
  }
  depends_on = [aws_s3_bucket.s3]
}

resource "aws_s3_bucket_cors_configuration" "cors_configuration" {
  for_each = { for k, v in var.s3_data : k => v if v.cors_configuration != null }
  bucket   = aws_s3_bucket.s3[each.key].bucket

  cors_rule {
    allowed_headers = each.value.cors_configuration.allowed_headers
    allowed_methods = each.value.cors_configuration.allowed_methods
    allowed_origins = each.value.cors_configuration.allowed_origins
    expose_headers  = each.value.cors_configuration.expose_headers
    max_age_seconds = each.value.cors_configuration.max_age_seconds
  }
  depends_on = [aws_s3_bucket.s3]
}

resource "aws_s3_bucket_ownership_controls" "ownership_controls" {
  for_each = { for k, v in var.s3_data : k => v if v.bucket_acl != null }
  bucket = aws_s3_bucket.s3[each.key].id
  rule {
    object_ownership = each.value.bucket_acl.object_ownership
  }
  depends_on = [aws_s3_bucket.s3]
}

resource "aws_s3_bucket_public_access_block" "public_access_block_config" {
  for_each = { for k, v in var.s3_data : k => v if v.bucket_acl != null }
  bucket = aws_s3_bucket.s3[each.key].id
  block_public_acls       = each.value.bucket_acl.block_public_acls
  block_public_policy     = each.value.bucket_acl.block_public_policy
  ignore_public_acls      = each.value.bucket_acl.ignore_public_acls
  restrict_public_buckets = each.value.bucket_acl.restrict_public_buckets
}
resource "aws_s3_bucket_acl" "bucket_acl" {
  for_each = { for k, v in var.s3_data : k => v if v.bucket_acl != null }
  bucket = aws_s3_bucket.s3[each.key].id
  acl    = each.value.bucket_acl.type_acl
  depends_on = [
    aws_s3_bucket_ownership_controls.ownership_controls,
    aws_s3_bucket_public_access_block.public_access_block_config,
  ]
}

resource "aws_s3_bucket_policy" "public_policy" {
  for_each = { for k, v in var.s3_data : k => v if v.bucket_acl != null }

  bucket = aws_s3_bucket.s3[each.key].id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.s3[each.key].arn}/*"
      }
    ]
  })
  depends_on = [aws_s3_bucket.s3, aws_s3_bucket_acl.bucket_acl ]
}