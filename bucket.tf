resource "aws_s3_bucket" "bucket" {
  count = var.is_aggregator ? 1 : 0

  bucket = var.bucket_name
}

resource "aws_s3_bucket_acl" "bucket" {
  count = var.is_aggregator ? 1 : 0

  bucket = aws_s3_bucket.bucket[count.index].id
  acl    = "private"
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket" {
  count  = var.is_aggregator ? 1 : 0
  bucket = aws_s3_bucket.bucket[count.index].id

  rule {
    id     = "log"
    status = "Enabled"

    transition {
      days          = var.transition_to_glacier
      storage_class = "GLACIER"
    }

    expiration {
      days = var.expiration
    }
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket" {
  count = var.is_aggregator ? 1 : 0

  bucket = aws_s3_bucket.bucket[count.index].bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.bucket_kms_master_key
      sse_algorithm     = var.bucket_sse_algorithm
    }
  }
}


data "aws_iam_policy_document" "config" {
  statement {
    actions = ["s3:GetBucketAcl"]
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    resources = ["arn:aws:s3:::${var.bucket_name}"]
  }

  statement {
    actions = ["s3:ListBucket"]
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    resources = ["arn:aws:s3:::${var.bucket_name}"]
  }

  statement {
    actions = ["s3:PutObject"]
    principals {
      type        = "Service"
      identifiers = ["config.amazonaws.com"]
    }
    resources = ["arn:aws:s3:::${var.bucket_name}/AWSLogs/*"]
    condition {
      test     = "StringLike"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

resource "aws_s3_bucket_policy" "config" {
  count  = var.is_aggregator ? 1 : 0
  bucket = aws_s3_bucket.bucket[0].id
  policy = data.aws_iam_policy_document.config.json
}
