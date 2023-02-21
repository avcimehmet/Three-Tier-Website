resource "aws_security_group" "Website-deployment-RDS" {
  name        = "Website-deployment-RDS (v${var.infrastructure_version})"
  description = "Website-deployment-RDS"
  vpc_id      = aws_vpc.Website-deployment.id

  tags = {
    Name = "Website-deployment-RDS (v${var.infrastructure_version})"
  }
}

resource "aws_security_group_rule" "Website-deployment-RDS-inbound-mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = aws_security_group.Website-deployment-RDS.id
  source_security_group_id = aws_security_group.Website-deployment-AppServer.id
}
