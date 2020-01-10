resource "aws_config_aggregate_authorization" "aggregation_authorization" {
  count      = var.is_aggregator ? 1 : 0
  account_id = var.aggregator_account_id
  region     = var.aggregator_account_region
}

resource "aws_config_configuration_aggregator" "configuration_aggregator" {
  count = var.is_aggregator ? 1 : 0
  name  = "aggregator"
  account_aggregation_source {
    account_ids = distinct(concat([var.aggregator_account_id], var.source_account_ids))
    all_regions = true
  }
}
