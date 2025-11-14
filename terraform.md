# Terraform (Infrastructure as Code) Tool

Terraform is an open-source Infrastructure as Code tool by HashiCorp that lets you define, provision, and manage infrastructure across multiple cloud providers using declarative configuration files.  
It ensures consistency, scalability, and easy automation of infrastructure.

---

**AWS Services**
- EC2, S3, VPC, EKS (Elastic Kubernetes Cluster), Aurora, RDS (database)
- We are creating them manually.
- Terraform helps us to automate them, called as infrastructure as code.

---

**History**
- Mishael Hashi Moto - created terraform  
2014 (create) -> 2017 (open source) -> 2023 (Business Source Language) -> 2025 (IBM acquire)

---

**Why Terraform Acquires?**  
Field Engineer -> Network Engineer -> Storage Engineer -> Backup Engineer -> Application Team  
|--------------------------- Replaced by Terraform -------------------------------|  

---

**Basic Syntax of terraform file**    
\<block\> \<parameters\> {    
    \<arguments\>    
}    

*Example*    
resource local_file myfile {    
    filename = "example.txt"    
    content = "This is an example."    
}    

*Explaining the example*    
resource resource_type resource_name {    
    -- resource_args --    
}    

**Accepted value for \<block\>**    
    1. for infrastructure: resource    
    2. for output: output    
    3. for variable: variable    
    4. for region: provider    
    5. for add required_provider: terraform   
    6. for module: module

---

**Terraform providers**
- local is the default provider
- aws is the new added provider using terraform.tf

---

**Install AWS CLI**    

aws cli - utility allows the machine to connect with aws account    

```bash
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"    
unzip awscliv2.zip    
sudo ./aws/install    
aws --version

aws configure
    AWS Access Key ID:
    AWS Secret Access Key:
    Default region name:
    Default output format:
```

## Terraform State Management & Backends

**🌱 What is Terraform State?**    

Terraform is declarative — you write code (HCL) that describes what your infrastructure should look like.    
But Terraform also needs to know what your infrastructure currently looks like — otherwise, it can’t tell what needs to be created, changed, or destroyed.    

That’s what the Terraform state file (terraform.tfstate) is for.    

**🗂 Example**    

Let’s say you have this:    

```bash
resource "aws_instance" "web" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
}
```

When you run:    
```
terraform apply    
```

Terraform: Creates an EC2 instance on AWS.    
Saves details (like its instance ID, IP address, etc.) inside terraform.tfstate.    

Your terraform.tfstate might look like:    

```bash
{
  "resources": [
    {
      "type": "aws_instance",
      "name": "web",
      "instances": [
      {
          "attributes": {
            "id": "i-0abcd1234",
            "ami": "ami-12345678",
            "instance_type": "t2.micro"
          }
        }
      ]
    }
  ]
}
```

So next time you change your .tf file, Terraform compares your desired state (code) vs. current state (tfstate file) to decide what to do.    

**⚠️ Why State Matters**    

Without state:    
Terraform would have to query all cloud resources every time (very slow & sometimes impossible).    
It wouldn’t know which resources it manages vs. ones created manually.    
Collaboration would break (because different people might apply conflicting changes).    
So the state file is critical — it must be accurate and consistent.    

**💾 Default State Storage (Local Backend)**    

By default, Terraform stores state locally — in a file called terraform.tfstate in your project folder.    
That’s fine for:    
Simple, personal projects    
Local testing or learning    
But it’s not safe for teams, because:    
Only one person has the file    
You risk overwriting changes    
No locking (two people could apply at once and break things) 

**☁️ Remote State & Backends**    

To solve those issues, Terraform lets you store the state remotely using backends.    
A backend is basically where and how Terraform stores and accesses state.    

| Backend Type                     | Description                                                               | Example        |
| -------------------------------- | ------------------------------------------------------------------------- | -------------- |
| **Local**                        | Default, stores `terraform.tfstate` locally                               | Local file     |
| **S3**                           | Stores state in an AWS S3 bucket                                          | AWS S3         |
| **GCS**                          | Stores state in Google Cloud Storage                                      | GCP GCS bucket |
| **AzureRM**                      | Stores state in Azure Blob Storage                                        | Azure          |
| **Terraform Cloud / Enterprise** | Stores state remotely in Terraform Cloud, includes locking, history, etc. | terraform.io   |

**🧭 Example: S3 Backend**    

Let’s say you want to store your Terraform state in an S3 bucket and lock it with DynamoDB.    
Here’s how you configure it in your Terraform project:    

```bash
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

Then run:    
```
    terraform init    
```

Terraform will:    
- Set up your S3 backend.    
- Upload your local terraform.tfstate to S3.    
- Use DynamoDB for state locking (prevents multiple applies at once).    
