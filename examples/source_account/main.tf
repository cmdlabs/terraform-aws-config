variable "bucket_name" {
  default = "config-bucket-1c5a1978-d138-4084-a3b4-fd4c403a89a0"
}

module "source" {
  source        = "../../"
  is_aggregator = false
  bucket_name   = var.bucket_name
}
