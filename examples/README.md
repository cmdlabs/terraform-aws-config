# Examples

## Multi-account example

The two examples in this directory assume two AWS accounts and set up a Config Aggregator in one account and a Source Account that points to its S3 Bucket in the other.

### Aggregator account

The example in [./aggregator_account](./aggregator_account) directory assumes two AWS accounts and sets up the Config Aggregator.

So as to avoid committing secrets to the revision history, environment variables need to be used to pass the Account ID to this example:

```text
▶ export TF_VAR_bucket_name=config-bucket-"$(uuidgen | tr 'A-Z' 'a-z')"  # bucket name must be globally unique
▶ cd ./aggregator_account
▶ terraform init
▶ TF_VAR_aggregator_account_id=xxxxxxxxxxxx TF_VAR_source_account_id=yyyyyyyyyyyy terraform apply
```

### Source account

The example in [./source_account](./source_account) meanwhile sets up the Source Account.

Switch to the second account and then:

```text
▶ cd ../source_account
▶ terraform init
▶ terraform apply
```

### Tear down

To tear down the Source Account:

```text
▶ terraform destroy
```

Then switch to the Aggregator Account and:

```text
▶ aws s3 rb s3://"$TF_VAR_bucket_name" --force
▶ cd ../aggregator_account
▶ TF_VAR_aggregator_account_id=xxxxxxxxxxxx TF_VAR_source_account_id=yyyyyyyyyyyy terraform destroy
```
