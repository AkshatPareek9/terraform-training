# Flow of Execution

- terraform.md    =    [Provide AWS provider]
- s3.tf           =    [Create S3 bucket]
- providers.tf    =    [provide region]
- dynamodb.tf     =    [generate LockID table]

```bash
terraform init
terraform plan
terraform apply -auto-approve
```
