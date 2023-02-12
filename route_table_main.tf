resource "aws_route_table" "Website-deployment-main" {
  vpc_id = aws_vpc.Website-deployment.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Website-deployment.id
  }

  tags = {
    Name = "Website-deployment-main  (v${var.infrastructure_version})"
  }
}

resource "aws_route_table_association" "Website-deployment-main" {
  count          = 2
  subnet_id      = element(local.subnets, count.index)
  route_table_id = aws_route_table.Website-deployment-main.id
}