resource "aws_config_config_rule" "config_rules" {
  for_each = var.config_rules
  name     = each.key
  source {
    owner             = each.value.source.owner
    source_identifier = each.value.source.source_identifier
  }
  depends_on = ["aws_config_configuration_recorder.config"]
}
