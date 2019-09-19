variable "aggregator_account_id" {}
variable "source_account_id" {}

variable "bucket_name" {
  default = "config-bucket-1c5a1978-d138-4084-a3b4-fd4c403a89a0"
}

module "aggregator" {
  source                    = "../../"
  is_aggregator             = true
  aggregator_account_id     = var.aggregator_account_id
  aggregator_account_region = "ap-southeast-2"
  source_account_ids        = [var.source_account_id]
  bucket_name               = var.bucket_name
}
