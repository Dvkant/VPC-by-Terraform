provider "aws" {
    region = var.region
}

resource "aws_instance" "demo-server" {

    ami = var.ami
    key_name = var.keypair
    instance_type = var.instance_type
    associate_public_ip_address = true
    subnet_id = aws_subnet.demo-subnet.id
    vpc_security_group_ids = [aws_security_group.demo-vpc-sg.id]

}

// Create VPC
resource "aws_vpc" "demo-main" {
  cidr_block = var.vpc_cidr
}

// Create subnet
resource "aws_subnet" "demo-subnet" {
  vpc_id     = aws_vpc.demo-main.id
  cidr_block = var.subnet_cidr
  availability_zone = var.subnet_az

  tags = {
    Name = "demo-subnet"
  }
}

// Create internet getway
resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-main.id

  tags = {
    Name = "demo-igw"
  }
}

// Create route table
resource "aws_route_table" "demo-rt" {
  vpc_id = aws_vpc.demo-main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-igw.id
  }
  tags = {
    Name = "demo-rt"
  }
}

// associate subnet with route table
resource "aws_route_table_association" "demo-rt-association" {
  subnet_id      = aws_subnet.demo-subnet.id
  route_table_id = aws_route_table.demo-rt.id
}

// Create security group
resource "aws_security_group" "demo-vpc-sg" {
  name        = "demo-vpc-sg"
  //description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.demo-main.id

  ingress {
    //description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "demo-vpc-sg"
  }
}
