resource "aws_vpc" "main" {
  cidr_block           = var.vpc[0].cidr_block
  enable_dns_support   = var.vpc[0].enable_dns_support
  enable_dns_hostnames = var.vpc[0].enable_dns_hostnames
  tags = local.tags

}

resource "aws_subnet" "main1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnets[0].cidr_block
  availability_zone       = var.subnets[0].azs
  map_public_ip_on_launch = var.subnets[0].map_public_ip_on_launch

  tags = {
    Name = var.subnets[0].name
  }
}

resource "aws_subnet" "main2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnets[1].cidr_block
  availability_zone       = var.subnets[1].azs
  map_public_ip_on_launch = var.subnets[1].map_public_ip_on_launch

  tags = {
    Name = var.subnets[1].name
  }
}

resource "aws_subnet" "main3" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnets[2].cidr_block
  availability_zone = var.subnets[2].azs

  tags = {
    Name = var.subnets[2].name
  }
}

resource "aws_subnet" "main4" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnets[3].cidr_block
  availability_zone = var.subnets[3].azs

  tags = {
    Name = var.subnets[3].name
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.igw
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.route_tables[0]
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.route_tables[1]
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.main1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.main2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.main3.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.main4.id
  route_table_id = aws_route_table.private.id
}

