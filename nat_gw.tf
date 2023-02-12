resource "aws_nat_gateway" "NAT_gw" {
  allocation_id = aws_eip.elasticIP.id
  subnet_id     = aws_subnet.Website-deployment-public[0].id

  tags = {
    Name = "NAT gw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.Website-deployment]
}

resource "aws_eip" "elasticIP" {
  vpc      = true
  tags = {
    Name = "NAT gw EIP"
  }
}