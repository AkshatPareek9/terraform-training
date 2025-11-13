terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "terraform-state-bucket"
    key = "terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "Terraform-State-Table"
  }
}
