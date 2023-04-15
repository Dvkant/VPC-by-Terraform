variable "region" {
    default = "ap-south-1"
}

variable "ami" {
    default = "ami-05afd67c4a44cc983"
}

variable "keypair" {
    default = "Server-key"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "vpc_cidr" {
    default = "10.10.0.0/16"
}

variable "subnet_cidr" {
    default = "10.10.1.0/24"
}

variable "subnet_az" {
    default = "ap-south-1a"
}