resource "aws_security_group" "Website_deployment_LB" {
  name        = "Website_deployment_LB (v${var.infrastructure_version})"
  description = "Website_deployment_LB"
  vpc_id      = aws_vpc.Website-deployment.id

  tags = {
    Name = "Website_deployment_LB (v${var.infrastructure_version})"
  }
}

resource "aws_security_group_rule" "Website_deployment_LB_inbound_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.Website_deployment_LB.id
}

resource "aws_security_group_rule" "Website_deployment_LB_inbound_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.Website_deployment_LB.id
}

resource "aws_security_group_rule" "Website_deployment_LB_inbound_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.Website_deployment_LB.id
}

resource "aws_security_group_rule" "Website_deployment_LB_outound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.Website_deployment_LB.id
}
