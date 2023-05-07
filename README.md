# VPC By Terraform

The Terraform configuration creates an AWS VPC with a public subnet, an internet gateway, a route table with a default route to the internet gateway, and a security group allowing SSH access to the EC2 instance. The EC2 instance is created within the public subnet and is publicly accessible with a specified AMI, instance type, and keypair.
