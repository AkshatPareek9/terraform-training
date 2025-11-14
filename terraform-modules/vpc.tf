# 1. Name
# 2. subnets - private
# 3. subnets - public
# 4. NAT
# 5. Gateway
# 6. AZ
# 7. CIDR
# 8. Tags

module "vpc" {
    # will search on internet
    source = "terraform-aws-modules/vpc/aws"

    name = "terraform-vpc"
    private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
    enable_nat_gateway = true
    enable_vpn_gateway = true
    azs = ["us-east-2a","us-east-2b"]
    cidr = "10.0.0.0/16"
     
  tags {
    Name = 
    Environment = var.env
  }
} 
