#!/usr/bin/env bash
# shellcheck disable=SC1091,SC2164,SC2154,SC2155,SC2103

. shunit2/test_helper.sh

vars=(
  AGGREGATOR_AWS_ACCESS_KEY_ID
  AGGREGATOR_AWS_SECRET_ACCESS_KEY
  SOURCE_AWS_ACCESS_KEY_ID
  SOURCE_AWS_SECRET_ACCESS_KEY
  TF_VAR_aggregator_account_id
  TF_VAR_source_account_id
)
validateVars

switchAccount() {
  local role="$1"
  eval 'export AWS_ACCESS_KEY_ID="$'"$role"'_AWS_ACCESS_KEY_ID"'
  eval 'export AWS_SECRET_ACCESS_KEY="$'"$role"'_AWS_SECRET_ACCESS_KEY"'
}

#export TF_VAR_bucket_name=config-bucket-"$(uuidgen | tr 'A-Z' 'a-z')"  # bucket name must be globally unique
export TF_VAR_bucket_name=config-bucket-d7b7f28f-4553-4309-8867-c0cdcd5415fe

testAggregatorAccount() {
  switchAccount 'AGGREGATOR'

  cd aggregator_account

  if ! terraform apply -auto-approve ; then
    fail "terraform did not apply"
    startSkipping
  fi

  cd ..
}

testDeliveryChannelIsCreated() {
  switchAccount 'AGGREGATOR'

  number_of_delivery_channels=$(aws configservice \
    describe-delivery-channels --query 'length(DeliveryChannels)')

  assertEquals "did not find a delivery channel" \
    "1" "$number_of_delivery_channels"
}

testConfigRecorderIsCreated() {
  switchAccount 'AGGREGATOR'

  read -r role_arn name <<< "$(
    aws configservice describe-configuration-recorders --query \
      'ConfigurationRecorders[0].[roleARN, name]' --output text
  )"

  assertTrue "unexpected roleARN in ConfigurationRecorder" \
    "grep -q arn:aws:iam.*ConfigRole <<< $role_arn"

  assertEquals "unexpected name in ConfigurationRecorder" \
    "Config" "$name"
}

testAWSConfigIsRecording() {
  switchAccount 'AGGREGATOR'

  read -r recording last_status <<< "$(
    aws configservice describe-configuration-recorder-status --query \
      'ConfigurationRecordersStatus[0].[recording, lastStatus]' --output text
  )"

  assertEquals "ConfigurationRecordersStatus is not recording" "True" "$recording"
  assertEquals "ConfigurationRecordersStatus lastStatus is not SUCCESS" "SUCCESS" "$last_status"
}

testSourceAccount() {
  switchAccount 'SOURCE'

  cd source_account

  if ! terraform apply -auto-approve ; then
    fail "terraform did not apply"
    startSkipping
  fi

  cd ..
}

oneTimeTearDown() {
  if [ "$NO_TEARDOWN" != "true" ] ; then
    echo "tearing down source ..."
    switchAccount 'SOURCE'
    cd source_account
    terraform destroy -auto-approve
    cd ..

    echo "tearing down aggregator ..."
    switchAccount 'AGGREGATOR'
    cd aggregator_account
    terraform destroy -auto-approve
    cd ..

    aws s3 rb s3://"$TF_VAR_bucket_name" --force
  fi
}

. shunit2
