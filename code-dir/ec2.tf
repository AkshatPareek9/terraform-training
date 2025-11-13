# instance name
# image
# flavor(type)
# network
# storage
# count
# key pair
# security group -> ports inbound/outbound rules

# Key Pair
resource "aws_key_pair" "my_key" {
    key_name = "terraform-ec2-key"
    public_key = file("terraform-ec2-key.pub")
}

# VPC
resource "aws_default_vpc" "my_vpc" {
}

resource "aws_security_group" "my_security_group" {

    name = "terraform-security-group"
    description = "This is my automated terraform security group"
    vpc_id = aws_default_vpc.my_vpc.id        # interpolation

    # inbound rules
    #ssh
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "SSH open"
    }

    # http
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "HTTP open"
    }

    #tcp
    ingress {
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Flask App port open"
    }

    # outbound
    egress {
        from_port = 0
        to_port = 0
        protocol  = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "All access open for outbound"
    }

    tags = {
        Name = "terraform-security-group"
    }
}

resource "aws_instance" "my_instance" {

    # Creating multi-instances using count
    # count = 3
    # Creating multi-instances using for_each
    for_each = tomap ({
        InstanceA = "t2.micro",
        InstanceB = "t2.medium"
        # instanceA and instanceB tells that create 2 instances
    })
    depends_on = [aws_security_group.my_security_group,aws_key_pair.my_key]
    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_security_group.name]
    # Use below, when count is used
    #instance_type = var.ec2_instance_type
    instance_type = each.value
    ami = var.ec2_ami_id
    user_data = file("install_nginx.sh")
    root_block_device = {
        volume_size=var.ec2_storage_size
        volume_type="gp3"
        #gp = general purpose
    }

    tags = {
        # Name = "Terraform_Automated_Instance"
        Name = each.key
        Environment = var.env
    }

}

