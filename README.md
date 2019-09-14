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
|log_bucket|The log bucket to write S3 logs to|string|""|No|
|name|The name to use when naming resources|string|""|No|
|input_parameters|A map of strings in JSON format that is passed to the AWS Config rule Lambda function. The map is keyed by the rule names. This is merged with a map contained in locals, with the values supplied here overriding any default values|map(string)|{|No|
|input_parameters|A map of strings in JSON format that is passed to the AWS Config rule Lambda function. The map is keyed by the rule names. This is merged with a map contained in locals, with the values supplied here overriding any default values|map(string)|{|No|
|rules|The list of rules to enable in AWS Config. The names are identical to the ones used by AWS. These are used to name the rules and to refence into the input_parameters and source_idenitifers maps. The default is the minimum recommended list.|list(string)|[|No|
|rules_count|The count of the items in the rules list|number|8|No|
|scopes|This is a map of rule names to scope maps. Each scope can have one or both of the following tuples: (compliance_resource_id, compliance_resource_types), (tag_key, tag_value). This map is merged with a default map in locals, with the values in this map overriding the defaults. Defines which resources can trigger an evaluation for the rules. If you do not specify a scope, evaluations are triggered when any resource in the recording group changes.|"This|{|No|
|source_identifiers|A map of rule names to source identifiers. For AWS Config managed rules, a predefined identifier from a list. For example, IAM_PASSWORD_POLICY is a managed rule. This map will be merged with a default list in locals, with values in this list overriding those in locals|"DESIRED_INSTANCE_TYPE"|{|No|
|tags|A mapping of tags to assign to created resources|map(string)|{}|No|
|transition_to_glacier|The number of days to wait before transitioning an object to Glacier|number|30|No|

### Outputs

|Name|Description|
|------------|---------------------|
|bucket|The bucket name that config writes output to|
|bucket_arn|The bucket ARN that config writes output to|
|delivery_channel_id|The name of the delivery channel|
|recorder_id|Name of the recorder|
|rule_arns|The ARNs of the config rules|
|rule_ids|The IDs of the config rules|
|topic_arn|The ARN of the SNS topic AWS Config writes events to|

### Examples

TODO.

## License

Apache 2.0.
