resource "aws_vpc" "Website-deployment" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    Name = "Website-deployment (v${var.infrastructure_version})"
  }
}