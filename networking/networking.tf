
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