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

---

**Terraform providers**
- local is the default provider.    
- aws is the generated provider.    
