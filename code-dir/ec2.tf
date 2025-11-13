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
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}

# VPC
resource "aws_default_vpc" "my_vpc" {
}

resource "aws_security_group" my_security_group {

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

resource aws_ec2_instance my_instance {

    key_name = aws_key_pair.my_key.key_name
    security_groups = [aws_security_group.my_security_group.name]
    instance_type = t2.micro
    ami = "ami-ag34bdfh6bh8324324fghdw4g5"
    root_block_device = {
        volume_size=15
        volume_type="gp3"
    }

    tags = {
        Name = Terraform_Automated_Instance
    }

}

