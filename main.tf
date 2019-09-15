locals {
  config_name = "Config"
  topic_name  = "ConfigTopic"
}

resource "aws_config_configuration_recorder" "config" {
  name = local.config_name
  recording_group {
    include_global_resource_types = true
  }
  role_arn = aws_iam_role.config_role.arn
}

resource "aws_sns_topic" "config" {
  name = local.topic_name
}

resource "aws_config_delivery_channel" "config" {
  depends_on     = [aws_config_configuration_recorder.config]
  name           = local.config_name
  s3_bucket_name = aws_s3_bucket.config_bucket.id
  snapshot_delivery_properties {
    delivery_frequency = var.delivery_frequency
  }
  sns_topic_arn = aws_sns_topic.config.arn
}

resource "aws_config_configuration_recorder_status" "config" {
  depends_on = [aws_config_delivery_channel.config]
  is_enabled = var.enable_recorder
  name       = aws_config_configuration_recorder.config.name
}

resource "aws_config_config_rule" "rule" {
  count            = var.rules_count
  depends_on       = [aws_config_configuration_recorder.config]
  input_parameters = lookup(var.input_parameters, element(var.rules, count.index), "")
  name             = element(var.rules, count.index)

  source {
    owner             = "AWS"
    source_identifier = local.source_identifiers[element(var.rules, count.index)]
  }
}
