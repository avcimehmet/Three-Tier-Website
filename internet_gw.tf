resource "aws_internet_gateway" "Website-deployment" {
  vpc_id = aws_vpc.Website-deployment.id

  tags = {
    Name = "Website-deployment  (v${var.infrastructure_version}"
  }
}