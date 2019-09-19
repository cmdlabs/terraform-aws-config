# Examples

## Multi-account example

### Aggregator account

The example in [./aggregator_account](./aggregator_account) directory assumes two AWS accounts and sets up a Config Aggregator in one and invites the second account to join as a Config Source account.

So as to avoid committing secrets to the revision history, environment variables need to be used to pass the Account ID and email to this example:

```text
▶ cd ./aggregator_account
▶ terraform init
▶ TF_VAR_aggregator_account_id=xxxxxxxxxxxx TF_VAR_source_account_id=yyyyyyyyyyyy terraform apply
```

### Source account

TODO.

### Tear down

```text
▶ cd ../aggregator_account
▶ TF_VAR_aggregator_account_id=xxxxxxxxxxxx TF_VAR_source_account_id=yyyyyyyyyyyy terraform destroy
```
