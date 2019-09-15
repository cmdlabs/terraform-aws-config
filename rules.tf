resource "aws_config_config_rule" "eip_attached" {
  name = "eip_attached"

  source {
    owner             = "AWS"
    source_identifier = "EIP_ATTACHED"
  }

  scope {
    compliance_resource_types = [
      "AWS::EC2::EIP",
    ]
  }

  depends_on = ["aws_config_configuration_recorder.config"]
}

resource "aws_config_config_rule" "restricted_ssh" {
  name = "restricted-ssh"

  source {
    owner             = "AWS"
    source_identifier = "INCOMING_SSH_DISABLED"
  }

  scope {
    compliance_resource_types = [
      "AWS::EC2::SecurityGroup",
    ]
  }

  depends_on = ["aws_config_configuration_recorder.config"]
}

resource "aws_config_config_rule" "s3_bucket_logging_enabled" {
  name = "s3-bucket-logging-enabled"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_LOGGING_ENABLED"
  }

  scope {
    compliance_resource_types = [
      "AWS::S3::Bucket",
    ]
  }

  depends_on = ["aws_config_configuration_recorder.config"]
}

resource "aws_config_config_rule" "acm_certificate_expiration_check" {
  name = "acm-certificate-expiration-check"

  source {
    owner             = "AWS"
    source_identifier = "ACM_CERTIFICATE_EXPIRATION_CHECK"
  }

  scope {
    compliance_resource_types = [
      "AWS::ACM::Certificate",
    ]
  }

  depends_on = ["aws_config_configuration_recorder.config"]
}

resource "aws_config_config_rule" "ec2_instances_in_vpc" {
  name = "ec2-instances-in-vpc"

  source {
    owner             = "AWS"
    source_identifier = "INSTANCES_IN_VPC"
  }

  scope {
    compliance_resource_types = [
      "AWS::EC2::Instance",
    ]
  }

  depends_on = ["aws_config_configuration_recorder.config"]
}

resource "aws_config_config_rule" "s3_bucket_ssl_requests_only" {
  name = "s3-bucket-ssl-requests-only"

  source {
    owner             = "AWS"
    source_identifier = "S3_BUCKET_SSL_REQUESTS_ONLY"
  }

  scope {
    compliance_resource_types = [
      "AWS::S3::Bucket",
    ]
  }

  depends_on = ["aws_config_configuration_recorder.config"]
}

resource "aws_config_config_rule" "root_account_mfa_enabled" {
  name = "root-account-mfa-enabled"

  source {
    owner             = "AWS"
    source_identifier = "ROOT_ACCOUNT_MFA_ENABLED"
  }

  depends_on = ["aws_config_configuration_recorder.config"]
}
