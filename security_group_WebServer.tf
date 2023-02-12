resource "aws_security_group" "Website-deployment-WebServer" {
  name        = "Website-deployment-WebServer (v${var.infrastructure_version})"
  description = "Website-deployment-WebServer"
  vpc_id      = aws_vpc.Website-deployment.id

  tags = {
    Name = "Website-deployment-WebServer (v${var.infrastructure_version})"
  }
}

resource "aws_security_group_rule" "Website-deployment-WebServer-inbound-http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.Website-deployment-WebServer.id
}

resource "aws_security_group_rule" "Website-deployment-WebServer-inbound-https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.Website-deployment-WebServer.id
}

resource "aws_security_group_rule" "Website-deployment-WebServer-inbound-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.Website-deployment-WebServer.id
}

resource "aws_security_group_rule" "Website-deployment-WebServer-outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.Website-deployment-WebServer.id
}