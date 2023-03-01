locals {
  num_start_private = range(var.Subnet_count, var.Subnet_count * 2, 1)
}

resource "aws_subnet" "Website-deployment-public" {
  count                   = var.Subnet_count 
  vpc_id                  = aws_vpc.Website-deployment.id
  availability_zone       = element(var.availability_zones, count.index)
  cidr_block              = "10.0.${count.index + 1}.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public_Subnet ${element(var.availability_zones, count.index)} (v${var.infrastructure_version})"
  }
}

resource "aws_subnet" "Website-deployment-private" {
  count             = length(local.num_start_private) 
  vpc_id            = aws_vpc.Website-deployment.id
  availability_zone = element(var.availability_zones, count.index)
  cidr_block        = "10.0.${element(local.num_start_private, count.index) + 1}.0/24"

  tags = {
    Name = "Private_Subnet ${element(var.availability_zones, count.index)} (v${var.infrastructure_version})"
  }
}