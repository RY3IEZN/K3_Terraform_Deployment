resource "resource random_integer" "random" {
  min = 1
  max = 50
}

# create a vpc
resource "aws_vpc" "k3_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "company" : "k3_vpc-${random_integer.random.id}"
  }
  lifecycle {
    create_before_destroy = true
  }
}

# create a public subnet
resource "aws_subnet" "k3_public_subnet" {
  count                   = length(var.public_cidr)
  vpc_id                  = aws_vpc.k3_vpc.id
  cidr_block              = var.public_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availablity_zones.az.name[count.index]

  tags = {
    "company" : "k3_public_subnet_${count.index + 1}"
  }

}

# create a public subnet
resource "aws_subnet" "k3_public_subnet" {
  count                   = length(var.public_cidr)
  vpc_id                  = aws_vpc.k3_vpc.id
  cidr_block              = var.public_cidr[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availablity_zones.az.name[count.index]

  tags = {
    "company" : "k3_public_subnet_${count.index + 1}"
  }

}

# create a private subnet
resource "aws_subnet" "k3_private_subnet" {
  count             = length(var.private_cidr)
  vpc_id            = aws_vpc.k3_vpc.id
  cidr_block        = var.private_cidr[count.index]
  availability_zone = ["eu-west-2a", "eu-west-2b", "eu-west-2c"][count.index]

  tags = {
    "company" : "k3_private_subnet_${count.index + 1}"
  }

}

# create a internet gateway
resource "aws_internet_gateway" "k3_igw" {
  vpc_id = aws_vpc.k3_vpc.id

  tags = {
    company = "k3_igw"
  }
}

# create public route table
resource "aws_route_table" "k3_pubic_route_table" {
  vpc_id = aws_vpc.k3_vpc.id

  tags = {
    company = "k3_pubic_route_table"
  }
}

#create default route 
resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.k3_pubic_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.k3_igw.id
}

#create default route table
resource "aws_default_route_table" "k3_private_route_table" {
  default_route_table_id = aws_vpc.k3_vpc.default_route_table_id
}

# create route table association for public subnert
resource "aws_route_table_association" "k3_public_subnet_assoc" {
  subnet_id      = aws_subnet.k3_public_subnet.*.id[count.index]
  route_table_id = aws_route_table.k3_pubic_route_table.id

}

