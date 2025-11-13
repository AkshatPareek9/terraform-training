# Terraform Commands:

```bash
  # initiate the terraform, .terraform (for providing the template of the providers) and .terraform.lock.hcl file created
  terraform init

  # validating the .tf file
  terraform validate  

  # Telling the client what change will be happen on apply
  terraform plan  

  # Apply the terraform configuration
  terraform apply  

  # Store the planned output in a file
  terraform plan -out "output.txt"  

  # Apply the terraform configuration and made only those changes which is written in output.txt
  terraform apply "output.txt"

  # Destroy
  terraform destroy
  terraform destroy -auto-approve

  # Destory using output file
  terraform plan -destroy -out "destory.txt"
  terraform apply "destroy.txt"
```
