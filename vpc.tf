provider "aws" {
  region  = "ap-south-1"
  profile = "tf-user"

}

resource "aws_vpc" "vnet" {
  cidr_block = "192.168.0.0/16"

  tags = {
    Name = "VPC-TF"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vnet.id
  cidr_block              = "192.168.0.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.vnet.id
  cidr_block              = "192.168.1.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = false
  tags = {
    Name = "private-subnet"
  }
}

resource "aws_internet_gateway" "internet" {
  vpc_id = aws_vpc.vnet.id
  tags = {
    Name = "igw-vpc"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vnet.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet.id
  }

  tags = {
    Name = "Public-RT"
  }

}

resource "aws_route_table_association" "attach" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public-rt.id

}

resource "aws_eip" "elastic" {
  domain = "vpc"

}

resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.elastic.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "NAT-gw"
  }
}

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vnet.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.example.id
  }
  tags = {
    Name = "Private-RT"
  }
}

resource "aws_route_table_association" "attach2" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private-rt.id

}

output "vpc_id" {
  value = aws_vpc.vnet.id

}
