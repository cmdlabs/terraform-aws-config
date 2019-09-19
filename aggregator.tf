resource "aws_config_aggregate_authorization" "aggregation_authorization" {
  count      = var.is_aggregator ? 1 : 0
  account_id = var.aggregator_account_id
  region     = var.aggregator_account_region
}

resource "aws_config_configuration_aggregator" "configuration_aggregator" {
  count = var.is_aggregator ? 1 : 0
  name  = "aggregator"
  account_aggregation_source {
    account_ids = concat([var.aggregator_account_id], var.source_account_ids)
    all_regions = true
  }
}

resource "aws_s3_bucket" "bucket" {
  count = var.is_aggregator ? 1 : 0
  acl   = "private"

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
      aws_s3_bucket.bucket[0].arn,
      "${aws_s3_bucket.bucket[0].arn}/*",
    ]
    sid = "DenyUnsecuredTransport"
  }
}

resource "aws_s3_bucket_policy" "config" {
  count  = var.is_aggregator ? 1 : 0
  bucket = aws_s3_bucket.bucket[0].id
  policy = data.aws_iam_policy_document.config.json
}
