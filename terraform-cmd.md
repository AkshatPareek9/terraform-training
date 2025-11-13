# Terraform Commands:

```bash
  # initiate the terraform, .terraform (for providing the template of the providers) and .terraform.lock.hcl file created
  terraform init

  # validating the .tf file
  terraform validate

  # Telling the client what change will be happen on apply
  terraform plan

  # Apply the terraform configuration and this generates terraform.tfstate file
  terraform apply
  terraform apply -auto-approve

  # Store the planned output in a file
  terraform plan -out "output.txt"

  # Apply the terraform configuration and made only those changes which is written in output.txt
  terraform apply "output.txt"

  # Destroy
  terraform destroy
  terraform destroy -auto-approve

  # Destory using output file
  terraform plan -destroy -out "destroy.txt"
  terraform apply "destroy.txt"

  # Terraform state refresh
  terraform refresh

  # Terraform state list
  terraform state list

  # Terraform show the state
  terraform state show aws_key_pair.my_key

  # Remove if no need to maintain the state of the particular
  terraform state rm aws_key_pair.my_key

  # Command to maintain the state again
  terraform state aws_key_pair.my_key \<key_id\>
```
