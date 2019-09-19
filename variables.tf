variable "delivery_frequency" {
  type        = string
  description = "The frequency with which AWS Config recurringly delivers configuration snapshots. May be one of One_Hour, Three_Hours, Six_Hours, Twelve_Hours, or TwentyFour_Hours"
  default     = "TwentyFour_Hours"
}

variable "enable_recorder" {
  type        = bool
  description = "Whether the configuration recorder should be enabled or disabled"
  default     = true
}

variable "expiration" {
  type        = number
  description = "The number of days to wait before expiring an object"
  default     = 2555
}

variable "transition_to_glacier" {
  type        = number
  description = "The number of days to wait before transitioning an object to Glacier"
  default     = 30
}

variable "is_aggregator" {
  type        = bool
  description = "Whether the account is to be an aggregator or not"
  default     = false
}

variable "aggregator_account_id" {
  type        = string
  description = "The AWS Account ID of the aggregator account"
  default     = null
}

variable "aggregator_account_region" {
  type        = string
  description = "The AWS Region of the aggregator account"
  default     = null
}

variable "source_account_ids" {
  type        = list(string)
  description = "List of 12-digit account IDs of the accounts being aggregated"
  default     = []
}

variable "bucket_name" {
  type        = string
  description = "The bucket name - required by both aggregator and source accounts"
}

variable "config_rules" {
  type        = map(any)
  description = "A list of config rules. By not specifying, a minimum set of recommended rules are applied"
  default     = {
    eip_attached = {
      name = "eip-attached"
      source = {
        owner             = "AWS"
        source_identifier = "EIP_ATTACHED"
      }
      scope = {
        compliance_resource_types = ["AWS::EC2::EIP"]
      }
    }
    encrypted_volumes = {
      name = "encrypted-volumes"
      source = {
        owner             = "AWS"
        source_identifier = "ENCRYPTED_VOLUMES"
      }
      scope = {
        compliance_resource_types = ["AWS::EC2::SecurityGroup"]
      }
    }
    s3_bucket_logging_enabled = {
      name = "s3-bucket-logging-enabled"
      source = {
        owner             = "AWS"
        source_identifier = "S3_BUCKET_LOGGING_ENABLED"
      }
      scope = {
        compliance_resource_types = ["AWS::S3::Bucket"]
      }
    }
    acm_certificate_expiration_check = {
      name = "acm-certificate-expiration-check"
      source = {
        owner             = "AWS"
        source_identifier = "ACM_CERTIFICATE_EXPIRATION_CHECK"
      }
      scope = {
        compliance_resource_types = ["AWS::ACM::Certificate"]
      }
    }
    ec2_instances_in_vpc = {
      name = "ec2-instances-in-vpc"
      source = {
        owner             = "AWS"
        source_identifier = "INSTANCES_IN_VPC"
      }
      scope = {
        compliance_resource_types = ["AWS::EC2::Instance"]
      }
    }
    s3_bucket_ssl_requests_only = {
      name = "s3-bucket-ssl-requests-only"
      source = {
        owner             = "AWS"
        source_identifier = "S3_BUCKET_SSL_REQUESTS_ONLY"
      }
      scope = {
        compliance_resource_types = ["AWS::S3::Bucket"]
      }
    }
    root_account_mfa_enabled = {
      name = "root-account-mfa-enabled"
      source = {
        owner             = "AWS"
        source_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
      }
      scope = {
        compliance_resource_types = ["AWS::S3::Bucket"]
      }
    }
  }
}
