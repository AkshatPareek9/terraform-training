# terraform-training
Terraform is an open-source Infrastructure as Code (IaC) tool by HashiCorp that automates provisioning and management of cloud and on-premises resources. Using declarative configuration files, it ensures consistent, scalable, and version-controlled infrastructure across multiple cloud providers and environments.  

# 🌍 Terraform Infrastructure Setup

## 🧭 Overview
This project uses **Terraform** to automate the provisioning and management of cloud infrastructure. It ensures consistent, scalable, and version-controlled deployments across multiple environments.

## ✨ Features
- ✅ Declarative **Infrastructure as Code (IaC)**
- ☁️ Multi-cloud support — AWS, Azure, GCP
- ⚙️ Automated provisioning and teardown
- 🧩 Reusable and modular configuration
- 🚀 Scalable and repeatable deployments

## 🧱 Prerequisites
- 🔹 [Terraform](https://www.terraform.io/downloads.html) installed  
- 🔹 Cloud provider credentials configured (e.g., AWS CLI, Azure CLI, GCP SDK)

## 🧰 Usage
```bash
# 🪄 Initialize Terraform
terraform init

# 🔍 Preview infrastructure changes
terraform plan

# ⚡ Apply configuration
terraform apply

# 💣 Destroy infrastructure
terraform destroy

## 📂 Project Structure
.
├── main.tf          # Main Terraform configuration
├── variables.tf     # Variable definitions
├── outputs.tf       # Output values
└── README.md        # Project documentation

## 🧠 Best Practices

  🪶 Use workspaces or separate state files for environments  
  🛡️ Add .terraform/ and terraform.tfstate to .gitignore  
  👀 Always review changes before applying (terraform plan)  
  📦 Use remote state backends for team collaboration  
