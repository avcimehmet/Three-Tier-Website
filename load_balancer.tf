resource "aws_lb" "LB_Web_App" {
  name                             = "LbWebApp"
  internal                         = false
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.Website_deployment_LB.id]
  subnets                          = [for subnet in aws_subnet.Website-deployment-public : subnet.id]
  enable_cross_zone_load_balancing = true
  enable_deletion_protection       = false

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_listener" "LB_Web_App" {
  load_balancer_arn = aws_lb.LB_Web_App.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Lb_target_group.arn
  }
}