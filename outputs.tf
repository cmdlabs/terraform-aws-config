output "bucket" {
  description = "The bucket name that config writes output to"
  value       = aws_s3_bucket.bucket.bucket
}

output "bucket_arn" {
  description = "The bucket ARN that config writes output to"
  value       = aws_s3_bucket.bucket.arn
}

output "delivery_channel_id" {
  description = "The name of the delivery channel"
  value       = aws_config_delivery_channel.config.id
}

output "recorder_id" {
  description = "Name of the recorder"
  value       = aws_config_configuration_recorder.config.id
}

output "topic_arn" {
  description = "The ARN of the SNS topic AWS Config writes events to"
  value       = aws_sns_topic.config.arn
}
