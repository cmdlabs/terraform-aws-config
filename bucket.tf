locals {
  bucket_name = "ConfigBucket"
}

resource "aws_s3_bucket" "config_bucket" {
  acl    = "log-delivery-write"
  bucket = local.bucket_name

  lifecycle {
    prevent_destroy = true
  }

  lifecycle_rule {
    id      = "log"
    enabled = true

    transition {
      days          = var.transition_to_glacier
      storage_class = "GLACIER"
    }

    expiration {
      days = var.expiration
    }
  }

  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "s3/${local.bucket_name}/"
  }
  tags = var.tags
}

resource "aws_s3_bucket" "log_bucket" {
  acl = "private"
}

data "aws_iam_policy_document" "config" {
  statement {
    actions = [
      "s3:*",
    ]
    condition {
      test = "Bool"
      values = [
        "false",
      ]
      variable = "aws:SecureTransport"
    }
    effect = "Deny"
    principals {
      identifiers = [
        "*",
      ]
      type = "AWS"
    }
    resources = [
      aws_s3_bucket.config_bucket.arn,
      "${aws_s3_bucket.config_bucket.arn}/*",
    ]
    sid = "DenyUnsecuredTransport"
  }
}

resource "aws_s3_bucket_policy" "config" {
  bucket = aws_s3_bucket.config_bucket.id
  policy = data.aws_iam_policy_document.config.json
}
