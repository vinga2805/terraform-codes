resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "demo-vpc"
    Environment = var.env
  }
}
resource "aws_subnet" "sub1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.sub1_cidr
  map_public_ip_on_launch = "true"
  availability_zone  = "ap-south-1a"

  tags = {
    Name = "pub-sub-1"
    Environment = "stage"    
  }
}
resource "aws_subnet" "sub2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.sub2_cidr
  availability_zone  = "ap-south-1a"

  tags = {
    Name = "pri-sub-1"
    Environment = "stage"    
  }
}
resource "aws_subnet" "sub3" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.sub3_cidr
  map_public_ip_on_launch = "true"
  availability_zone  = "ap-south-1b"

  tags = {
    Name = "pub-sub-2"
    Environment = "stage"    
  }
}
resource "aws_subnet" "sub4" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.sub4_cidr
  availability_zone  = "ap-south-1b"

  tags = {
    Name = "pri-sub-2"
    Environment = "stage"    
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "demo-igw"
    Environment = "stage"  
  }
}
resource "aws_eip" "eip" {
  vpc      = true
}
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.sub1.id
}

resource "aws_route_table" "r1" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-route"
    Environment = "stage"  
  }
}

resource "aws_route_table" "r2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "private-route"
    Environment = "stage"  
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.sub1.id
  route_table_id = aws_route_table.r1.id
}
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.sub3.id
  route_table_id = aws_route_table.r1.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.sub2.id
  route_table_id = aws_route_table.r2.id
}
resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.sub4.id
  route_table_id = aws_route_table.r2.id
}
