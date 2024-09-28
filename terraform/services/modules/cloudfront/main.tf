resource "aws_cloudfront_origin_access_control" "oac" {
  for_each = var.cloudfront

  name                              = "${chomp(join("", [for k in keys(var.buckets) : k if can(regex(".*${each.value.bucket_name}.*", k))]))}-oac"
  description                       = "Origin Access Control for ${each.value.name}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "distribution" {
  for_each = var.cloudfront
   origin {
    domain_name              = "${chomp(join("", [for k in keys(var.buckets) : k if can(regex(".*${each.value.bucket_name}.*", k))]))}.s3.amazonaws.com"
    origin_id                = each.value.name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac[each.key].id
  }

  enabled             = each.value.enabled
  is_ipv6_enabled     = each.value.is_ipv6_enabled
  comment             = each.value.comment
  default_root_object = each.value.default_root_object

  # Manejo de Aliases
  aliases = length(each.value.alternate_domain_names) > 0 ? each.value.alternate_domain_names : []

  default_cache_behavior {
    target_origin_id       = each.value.name
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = each.value.default_ttl
    max_ttl     = each.value.max_ttl
  }

  dynamic "ordered_cache_behavior" {
    for_each = each.value.ordered_cache_behaviors
    content {
      path_pattern           = ordered_cache_behavior.value.path_pattern
      target_origin_id       = each.value.name
      viewer_protocol_policy = "redirect-to-https"

      allowed_methods = ordered_cache_behavior.value.allowed_methods
      cached_methods  = ordered_cache_behavior.value.cached_methods

      forwarded_values {
        query_string = ordered_cache_behavior.value.forwarded_values.query_string

        cookies {
          forward = ordered_cache_behavior.value.forwarded_values.cookies.forward
        }
      }

      min_ttl     = ordered_cache_behavior.value.min_ttl
      default_ttl = ordered_cache_behavior.value.default_ttl
      max_ttl     = ordered_cache_behavior.value.max_ttl
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # Manejo del Certificado
  viewer_certificate {
    cloudfront_default_certificate = length(each.value.domain) == 0 ? true : false

    # Incluir búsqueda del certificado basado en el dominio alternativo
    acm_certificate_arn = length(each.value.domain) > 0 ? data.aws_acm_certificate.certificate[each.key].arn : null

    ssl_support_method = "sni-only"
  }

  # Ignorar cambios manuales para evitar problemas en el ciclo de vida
  lifecycle {
    ignore_changes = [
      aliases,
      viewer_certificate[0].acm_certificate_arn,
      viewer_certificate[0].ssl_support_method,
    ]
  }
}

resource "aws_s3_bucket_policy" "cloudfront" {
  for_each = var.cloudfront

  bucket = chomp(join("", [for k in keys(var.buckets) : k if can(regex(".*${each.value.bucket_name}.*", k))]))

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipalReadOnly"
        Effect = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "arn:aws:s3:::${chomp(join("", [for k in keys(var.buckets) : k if can(regex(".*${each.value.bucket_name}.*", k))]))}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = "${aws_cloudfront_distribution.distribution[each.key].arn}"
          }
        }
      },
      {
        Sid    = "AllowS3AccessForOAC"
        Effect = "Allow"
        Principal = {
          # Utiliza la referencia al OAC aquí en vez de OAI
          AWS = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Control ${aws_cloudfront_origin_access_control.oac[each.key].id}" 
        }
        Action   = "s3:GetObject"
        Resource = "arn:aws:s3:::${chomp(join("", [for k in keys(var.buckets) : k if can(regex(".*${each.value.bucket_name}.*", k))]))}/*" 
      }
    ]
  })

  depends_on = [
    aws_cloudfront_distribution.distribution
  ]
}


data "aws_acm_certificate" "certificate" {
  for_each = {
    for key, cf in var.cloudfront :
    key => cf.domain
    if length(cf.domain) > 0
  }

  domain      = each.value # Usamos el valor directamente como es solo un dominio
  statuses    = ["ISSUED"]
  most_recent = true
}
