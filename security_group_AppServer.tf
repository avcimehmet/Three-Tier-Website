resource "aws_security_group" "Website-deployment-AppServer" {
  name        = "Website-deployment-AppServer (v${var.infrastructure_version})"
  description = "Website-deployment-AppServer"
  vpc_id      = aws_vpc.Website-deployment.id

  tags = {
    Name = "Website-deployment-AppServer (v${var.infrastructure_version})"
  }
}

resource "aws_security_group_rule" "Website-deployment-AppServer-inbound-http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.Website-deployment-AppServer.id
  source_security_group_id = "${aws_security_group.Website-deployment-WebServer.id}"
}

resource "aws_security_group_rule" "Website-deployment-AppServer-inbound-ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.Website-deployment-AppServer.id
  source_security_group_id = "${aws_security_group.Website-deployment-WebServer.id}"
}

resource "aws_security_group_rule" "Website-deployment-AppServer-inbound-https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.Website-deployment-AppServer.id
  source_security_group_id = "${aws_security_group.Website-deployment-WebServer.id}"
}

resource "aws_security_group_rule" "Website-deployment-AppServer-inbound-allICMP" {
  type              = "ingress"
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  security_group_id = aws_security_group.Website-deployment-AppServer.id
  source_security_group_id = "${aws_security_group.Website-deployment-WebServer.id}"
}

resource "aws_security_group_rule" "Website-deployment-AppServer-outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.Website-deployment-AppServer.id
}