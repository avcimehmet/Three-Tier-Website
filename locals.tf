locals {
  subnets_public        = aws_subnet.Website-deployment-public.*.id
  subnets_private       = aws_subnet.Website-deployment-private.*.id
  total_instance_count  = var.Subnet_count * var.Instance_count_per_subnet
}