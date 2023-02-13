resource "aws_nat_gateway" "NATgw" {
  allocation_id = aws_eip.elasticIP.id
  subnet_id     =  element(local.subnets_public, 0)

  tags = {
    Name = "NAT gw"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.Website-deployment, aws_eip.elasticIP]
}

resource "aws_eip" "elasticIP" {
  vpc      = true
  tags = {
    Name = "NAT gw EIP"
  }
}