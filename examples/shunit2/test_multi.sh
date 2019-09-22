#!/usr/bin/env bash
# shellcheck disable=SC1091,SC2164,SC2154,SC2155,SC2103

. shunit2/test_helper.sh

export TF_VAR_bucket_name=config-bucket-"$(uuidgen | tr 'A-Z' 'a-z')"  # bucket name must be globally unique

testAggregatorAccount() {
  switchAccount 'AGGREGATOR'

  cd aggregator_account

  if ! terraform apply -auto-approve ; then
    fail "terraform did not apply"
    startSkipping
  fi

  cd ..
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
