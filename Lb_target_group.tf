resource "aws_lb_target_group" "Lb_target_group" {
  name     = "Lb-target-group-v${var.infrastructure_version}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.Website-deployment.id

  health_check {
    port     = 80
    protocol = "HTTP"
    timeout  = 5
    interval = 10
  }
}

resource "aws_lb_target_group_attachment" "Lb_target_group_Attachment" {
  count            = var.Web_instance_count
  target_group_arn = aws_lb_target_group.Lb_target_group.arn
  target_id        = aws_autoscaling_group.asg_web_inst["${count.index}"].arn
  port             = 80
}
