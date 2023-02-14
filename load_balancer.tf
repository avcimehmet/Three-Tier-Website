resource "aws_lb" "LB_Web_App" {
  name               = "LbWebApp"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.Website-deployment-WebServer.id]
  subnets            = [for subnet in aws_subnet.Website-deployment-public : subnet.id]
  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}