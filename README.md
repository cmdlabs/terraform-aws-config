<!-- vim: set ft=markdown: -->
# terraform-aws-config

#### Table of contents

1. [Overview](#overview)
2. [AWS Config - Overview Diagram](#aws-config---overview-diagram)
3. [AWS Config](#aws-config)
    * [Resources docs](#resources-docs)
    * [Inputs](#inputs)
    * [Outputs](#outputs)
    * [Examples](#examples)
4. [License](#license)

## Overview

AWS Config catpures point in time snapshots of the environment to allow for point in time review of configuration. Additionally AWS Config can be utilised for automated action using AWS Config rules.

NOTE: Currently only supports AWS owned / managed rules - http://docs.aws.amazon.com/config/latest/developerguide/managed-rules-by-aws-config.html

Terraform >= 0.12 is required for this module.

## AWS Config - Overview Diagram

![AWSConfig|medium](docs/AWSConfig.png)

## AWS Config

### Resources docs

AWS Config automation includes the use of the following core Terraform resources:

- [`aws_config_config_rule`](https://www.terraform.io/docs/providers/aws/r/config_config_rule.html) - Provides an AWS Config Rule.
- [`aws_config_configuration_recorder_status`](https://www.terraform.io/docs/providers/aws/r/aws_config_configuration_recorder_status.html) - Manages status (recording / stopped) of an AWS Config Configuration Recorder.
- [`aws_config_configuration_recorder`](https://www.terraform.io/docs/providers/aws/r/config_configuration_recorder.html) - Provides an AWS Config Configuration Recorder.
- [`aws_config_delivery_channel`](https://www.terraform.io/docs/providers/aws/r/config_delivery_channel.html) - Provides an AWS Config Delivery Channel.

### Inputs

The below outlines the current parameters and defaults.

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
|delivery_frequency|The frequency with which AWS Config recurringly delivers configuration snapshots. May be one of One_Hour, Three_Hours, Six_Hours, Twelve_Hours, or TwentyFour_Hours|string|TwentyFour_Hours|No|
|enable_recorder|Whether the configuration recorder should be enabled or disabled|bool|true|No|
|expiration|The number of days to wait before expiring an object|number|2555|No|
|transition_to_glacier|The number of days to wait before transitioning an object to Glacier|number|30|No|

### Outputs

|Name|Description|
|------------|---------------------|
|bucket|The bucket name that config writes output to|
|bucket_arn|The bucket ARN that config writes output to|
|delivery_channel_id|The name of the delivery channel|
|recorder_id|Name of the recorder|
|topic_arn|The ARN of the SNS topic AWS Config writes events to|

### Examples

TODO.

## License

Apache 2.0.
