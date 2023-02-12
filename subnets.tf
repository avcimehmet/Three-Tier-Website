locals {
  subnet_count       = 2
  availability_zones = ["us-east-1a", "us-east-1b"]
}

resource "aws_subnet" "Website-deployment-public" {
  count                   = local.subnet_count
  vpc_id                  = aws_vpc.Website-deployment.id
  availability_zone       = element(local.availability_zones, count.index)
  cidr_block              = "10.0.${local.subnet_count * (var.infrastructure_version - 1) + count.index + 1}.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public_Subnet ${element(local.availability_zones, count.index)} (v${var.infrastructure_version})"
  }
}

resource "aws_subnet" "Website-deployment-private" {
  count                   = local.subnet_count
  vpc_id                  = aws_vpc.Website-deployment.id
  availability_zone       = element(local.availability_zones, count.index)
  cidr_block              = "10.0.${local.subnet_count * (var.infrastructure_version - 1) + count.index + 3}.0/24"

  tags = {
    Name = "Private_Subnet ${element(local.availability_zones, count.index)} (v${var.infrastructure_version})"
  }
}