# 🌍 Terraform Workspaces

**📘 Overview**

Terraform workspaces allow you to use a single Terraform configuration to manage multiple environments, such as:
- dev
- test
- stage
- prod

Each workspace keeps its own state file, which means resources in one workspace do not affect another.

---

**🧠 Why Use Workspaces?**

*✔️ Separate environments using the same code*

Each workspace maintains a separate state:

```bash
  dev → terraform.tfstate (dev)
  prod → terraform.tfstate (prod)
```

*✔️ Avoid duplicate code*

You don’t need separate folders like:

/dev
/prod

*✔️ Quick environment switching*

You can instantly switch between environments.

---

**📁 Recommended Folder Structure**
```
terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
└── README.md
```

All environments are handled through workspaces, not folders.

---

**🚀 Workspace Commands**
```
🔹 List existing workspaces
terraform workspace list

🔹 Create a new workspace
terraform workspace new dev

🔹 Switch to a workspace
terraform workspace select dev

🔹 View current workspace
terraform workspace show

🔹 Delete a workspace
# Must not be currently selected
terraform workspace delete dev
```

---

**📌 Using Workspace Name in Your Terraform Code**

You can use the built-in variable:

terraform.workspace

```
Example: Environment-specific naming
resource "aws_s3_bucket" "example" {
  bucket = "my-bucket-${terraform.workspace}"
}
```

If workspace = dev, bucket = my-bucket-dev.

*🔧 Using Workspace in Variables*
```
locals {
  env = terraform.workspace
}
```

Use it:
```
resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.instance_type[local.env]
}
```

Example variable map
```
variable "instance_type" {
  type = map(string)
  default = {
    dev  = "t2.micro"
    prod = "t3.medium"
  }
}
```

---

**🗂 State File Behavior with Workspaces**

Terraform stores separate state files by workspace.

```
Local backend example:
terraform.tfstate.d/
  ├── dev/
  │    └── terraform.tfstate
  └── prod/
       └── terraform.tfstate
```

S3 backend example:
key = "envs/dev/terraform.tfstate"
key = "envs/prod/terraform.tfstate"

**⚠️ When NOT to Use Workspaces**

Terraform Workspaces are NOT recommended for:
- ❌ Fully isolated production accounts
- ❌ Multi-account AWS setups
- ❌ Large infrastructure differences between environments

Use separate folders or separate AWS accounts for true environment isolation.

**🏗 Example Backend Setup (S3 + DynamoDB)**
```
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "envs/${terraform.workspace}/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
```

**🧪 Example Workflow**
```
Initialize backend
terraform init

Create environments
terraform workspace new dev
terraform workspace new prod

Deploy to dev
terraform workspace select dev
terraform apply

Deploy to prod
terraform workspace select prod
terraform apply
```

**📝 Summary**

Terraform workspaces allow multiple environments using one configuration.

Each workspace keeps its own state file.

Use terraform.workspace inside your code for dynamic config.

Best for small/medium projects with minor differences between environments.
