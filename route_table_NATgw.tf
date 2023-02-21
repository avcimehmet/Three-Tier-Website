resource "aws_route_table" "NATgw" {
  vpc_id     = aws_vpc.Website-deployment.id
  depends_on = [aws_nat_gateway.NATgw]

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NATgw.id
  }

  tags = {
    Name = "NATgw  (v${var.infrastructure_version})"
  }
}

resource "aws_route_table_association" "NATgw" {
  depends_on     = [aws_route_table.NATgw]
  count          = var.Subnet_count
  subnet_id      = element(local.subnets_private, count.index)
  route_table_id = aws_route_table.NATgw.id
}