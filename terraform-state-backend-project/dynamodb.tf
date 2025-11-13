resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "Terraform-State-Table"
  billing_mode   = "PAY_PER_REQUEST"           # pay when request
  # billing_mode   = "PROVISIONED"             # monthly bill
  hash_key       = "LockId"

  attribute {
    name = "LockId"
    type = "S"
  }

  tags = {
    Name        = "Terraform-State-Table"
  }
}
