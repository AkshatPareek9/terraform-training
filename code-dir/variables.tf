variable "ec2_instance_type" {
  default="t2.micro"
  type=string
}
variable "ec2_ami_id" {
  default="ami-ag34bdfh6bh8324324fghdw4g5"
  type=string
}
variable "ec2_storage_size" {
  default="10"
  type=number
}
variable "env" {
  default="dev"
  type=string
}
