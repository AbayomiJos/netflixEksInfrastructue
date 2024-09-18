# VPC
resource "aws_vpc" "netflix_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "netflix-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "netflix_igw" {
  vpc_id = aws_vpc.netflix_vpc.id
  tags = {
    Name = "netflix-igw"
  }
}

# NAT Gateway
resource "aws_eip" "netflix_nat_eip" {
  vpc = true
}

resource "aws_nat_gateway" "netflix_nat_gw" {
  allocation_id = aws_eip.netflix_nat_eip.id
  subnet_id     = aws_subnet.netflix_public_subnet_1.id
  tags = {
    Name = "netflix-nat-gateway"
  }
}

# Public Subnets
resource "aws_subnet" "netflix_public_subnet_1" {
  vpc_id                  = aws_vpc.netflix_vpc.id
  cidr_block              = var.public_subnet_1_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_1
  tags = {
    Name = "netflix-public-subnet-1"
  }
}

resource "aws_subnet" "netflix_public_subnet_2" {
  vpc_id                  = aws_vpc.netflix_vpc.id
  cidr_block              = var.public_subnet_2_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_2
  tags = {
    Name = "netflix-public-subnet-2"
  }
}

# Private Subnets
resource "aws_subnet" "netflix_private_subnet_1" {
  vpc_id            = aws_vpc.netflix_vpc.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = var.availability_zone_1
  tags = {
    Name = "netflix-private-subnet-1"
  }
}

resource "aws_subnet" "netflix_private_subnet_2" {
  vpc_id            = aws_vpc.netflix_vpc.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = var.availability_zone_2
  tags = {
    Name = "netflix-private-subnet-2"
  }
}

# Public Route Table
resource "aws_route_table" "netflix_public_rt" {
  vpc_id = aws_vpc.netflix_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.netflix_igw.id
  }
  tags = {
    Name = "netflix-public-rt"
  }
}

# Private Route Table
resource "aws_route_table" "netflix_private_rt" {
  vpc_id = aws_vpc.netflix_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.netflix_nat_gw.id
  }
  tags = {
    Name = "netflix-private-rt"
  }
}

# Route Table Associations
resource "aws_route_table_association" "netflix_public_rt_assoc_1" {
  subnet_id      = aws_subnet.netflix_public_subnet_1.id
  route_table_id = aws_route_table.netflix_public_rt.id
}

resource "aws_route_table_association" "netflix_public_rt_assoc_2" {
  subnet_id      = aws_subnet.netflix_public_subnet_2.id
  route_table_id = aws_route_table.netflix_public_rt.id
}

resource "aws_route_table_association" "netflix_private_rt_assoc_1" {
  subnet_id      = aws_subnet.netflix_private_subnet_1.id
  route_table_id = aws_route_table.netflix_private_rt.id
}

resource "aws_route_table_association" "netflix_private_rt_assoc_2" {
  subnet_id      = aws_subnet.netflix_private_subnet_2.id
  route_table_id = aws_route_table.netflix_private_rt.id
}
