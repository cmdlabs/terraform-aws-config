variable "aggregator_account_id" {}
variable "source_account_id" {}

module "config" {
  source = "../../"
  is_aggregator = true
  aggregator_account_id = var.aggregator_account_id
  aggregator_account_region = "ap-southeast-2"
  source_account_ids = [var.source_account_id]
}
