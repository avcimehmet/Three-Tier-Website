resource "aws_lb_target_group" "Lb_target_group" {
  name     = "Lb-target-group-v${var.infrastructure_version}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.Website-deployment.id

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    port                = 80
    protocol            = "HTTP"
    timeout             = 5
    interval            = 10
  }

  depends_on = [
    aws_lb.LB_Web_App
  ]
}
