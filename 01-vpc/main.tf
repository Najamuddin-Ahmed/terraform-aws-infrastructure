terraform {
  required_providers {
    aws={
        source = "hashicorp/aws"
        version = "~>6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "esell_vpc" {
  cidr_block = "10.0.0.0/16"
    tags = {
        Name = "esell_vpc"
    }
}

#create a public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.esell_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
    tags = {
        Name = "public_subnet"
    }
}

#create an private subnet
resource "aws_subnet" "private_subnet" { 
  vpc_id            = aws_vpc.esell_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
    tags = {
        Name = "private_subnet"
    }
}

# Create a route table for the public subnet
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.esell_vpc.id
  tags = {
    Name = "public_route_table"
  }     
}

# Create a internet gateway
resource "aws_internet_gateway" "esell_igw" {
  vpc_id = aws_vpc.esell_vpc.id
  tags = {
    name = "esell_igw"
  }
}

# create a route to the subnet to route table
resource "aws_route_table_association" "rta_public" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# attach the internet gateway to the route table
resource "aws_route" "public_route" {
  route_table_id     = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id     = aws_internet_gateway.esell_igw.id
}

# create a private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.esell_vpc.id
  tags = {
    Name = "private_route_table"
  }
}

# connect the private subnet to the private route table
resource "aws_route_table_association" "rta_private" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}

# create a ec2 instance
resource "aws_instance" "my_server" {
  ami           = "ami-0b6d9d3d33ba97d99"
  instance_type = "t3.micro" 
  tags = {
    Name = "my_server"
  }
}
