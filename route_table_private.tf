resource "aws_route_table" "Website-deployment-private" {
  vpc_id = aws_vpc.Website-deployment.id

  tags = {
    Name = "Website-deployment-private  (v${var.infrastructure_version})"
  }
}
