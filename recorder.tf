locals {
  config_name = "Config"
}

resource "aws_config_configuration_recorder" "config" {
  name = local.config_name
  recording_group {
    include_global_resource_types = true
  }
  role_arn = aws_iam_role.config_role.arn
}

resource "aws_config_delivery_channel" "config" {
  name           = local.config_name
  s3_bucket_name = var.bucket_name
  snapshot_delivery_properties {
    delivery_frequency = var.delivery_frequency
  }
  sns_topic_arn = aws_sns_topic.config.arn
  depends_on    = [aws_config_configuration_recorder.config]
}

resource "aws_config_configuration_recorder_status" "config" {
  is_enabled = var.enable_recorder
  name       = aws_config_configuration_recorder.config.name
  depends_on = [aws_config_delivery_channel.config]
}
