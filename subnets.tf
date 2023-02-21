resource "aws_subnet" "Website-deployment-public" {
  count                   = var.Subnet_count
  vpc_id                  = aws_vpc.Website-deployment.id
  availability_zone       = element(var.availability_zones, count.index)
  cidr_block              = "10.0.${var.Subnet_count * (var.infrastructure_version - 1) + count.index + 1}.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public_Subnet ${element(var.availability_zones, count.index)} (v${var.infrastructure_version})"
  }
}

resource "aws_subnet" "Website-deployment-private" {
  count             = var.Subnet_count
  vpc_id            = aws_vpc.Website-deployment.id
  availability_zone = element(var.availability_zones, count.index)
  cidr_block        = "10.0.${var.Subnet_count * (var.infrastructure_version - 1) + count.index + 3}.0/24"

  tags = {
    Name = "Private_Subnet ${element(var.availability_zones, count.index)} (v${var.infrastructure_version})"
  }
}