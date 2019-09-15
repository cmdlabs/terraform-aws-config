locals {
  topic_name = "ConfigTopic"
}

resource "aws_sns_topic" "config" {
  name = local.topic_name
}
