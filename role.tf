locals {
  role_name = "ConfigRole"
}

resource "aws_iam_role" "config_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  name               = local.role_name
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["config.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role_policy_attachment" "config" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSConfigRole"
  role       = aws_iam_role.config_role.name
}

resource "aws_iam_role_policy" "config" {
  name   = "config-bucket-access"
  policy = data.aws_iam_policy_document.role_policy.json
  role   = aws_iam_role.config_role.id
}

data "aws_iam_policy_document" "role_policy" {
  statement {
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${var.bucket_name}/AWSLogs/*"]
    condition {
      test     = "StringLike"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }

  statement {
    actions   = ["s3:GetBucketAcl"]
    resources = ["arn:aws:s3:::${var.bucket_name}"]
  }

  statement {
    actions   = ["sns:Publish"]
    resources = [aws_sns_topic.config.arn]
  }
}
