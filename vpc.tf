# VPC
resource "aws_vpc" "toyeglobal_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "toyeglobal-vpc"
  }
}

# Subnets
resource "aws_subnet" "toyeglobal_subnet1" {
  vpc_id            = aws_vpc.toyeglobal_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"
  tags = {
    Name = "toyeglobal-subnet1"
  }
}

resource "aws_subnet" "toyeglobal_subnet2" {
  vpc_id            = aws_vpc.toyeglobal_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2b"
  tags = {
    Name = "toyeglobal-subnet2"
  }
}

resource "aws_subnet" "toyeglobal_subnet3" {
  vpc_id            = aws_vpc.toyeglobal_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "eu-west-2c"
  tags = {
    Name = "toyeglobal-subnet3"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "toyeglobal_igw" {
  vpc_id = aws_vpc.toyeglobal_vpc.id
}

# Elastic IP for NAT Gateway
resource "aws_eip" "toyeglobal_eip" {}

# NAT Gateway
resource "aws_nat_gateway" "toyeglobal_nat_gateway" {
  allocation_id = aws_eip.toyeglobal_eip.id
  subnet_id     = aws_subnet.toyeglobal_subnet1.id
}

# Public Route Table
resource "aws_route_table" "toyeglobal_public_rt" {
  vpc_id = aws_vpc.toyeglobal_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.toyeglobal_igw.id
  }
}

# Associate all subnets with the public route table
resource "aws_route_table_association" "toyeglobal_subnet1_association" {
  subnet_id      = aws_subnet.toyeglobal_subnet1.id
  route_table_id = aws_route_table.toyeglobal_public_rt.id
}

resource "aws_route_table_association" "toyeglobal_subnet2_association" {
  subnet_id      = aws_subnet.toyeglobal_subnet2.id
  route_table_id = aws_route_table.toyeglobal_public_rt.id
}

resource "aws_route_table_association" "toyeglobal_subnet3_association" {
  subnet_id      = aws_subnet.toyeglobal_subnet3.id
  route_table_id = aws_route_table.toyeglobal_public_rt.id
}

# Private Route Table
resource "aws_route_table" "toyeglobal_private_rt" {
  vpc_id = aws_vpc.toyeglobal_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.toyeglobal_nat_gateway.id
  }
}
