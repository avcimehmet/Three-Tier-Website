locals {
  subnets_public = aws_subnet.Website-deployment-public.*.id
  subnets_private = aws_subnet.Website-deployment-private.*.id
}