resource "aws_launch_configuration" "lc_asg_web" {
  name_prefix     = "lc-Three-Tier"
  image_id        = data.aws_ami.amzlinux.id
  security_groups = ["${aws_security_group.Website-deployment-WebServer.id}"]
  instance_type   = "t2.micro"
  key_name        = "mykey"

  user_data = file("./userdata-WebServer.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg_web_inst" {
  name                 = "asg-Three-Tier-web-inst"
  vpc_zone_identifier  = local.subnets_public
  launch_configuration = aws_launch_configuration.lc_asg_web.name

  min_size = local.total_instance_count
  max_size = "${local.total_instance_count}" * 2

  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }

  tag {
    key                 = "Name"
    value               = "web-server"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "asp_web_inst" {
  name                   = "asp_web_inst"
  scaling_adjustment     = local.total_instance_count
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg_web_inst.name
}

resource "aws_autoscaling_attachment" "asa_asg_web" {
  autoscaling_group_name = aws_autoscaling_group.asg_web_inst.id
  lb_target_group_arn    = aws_lb_target_group.Lb_target_group.arn
}

resource "aws_cloudwatch_metric_alarm" "asg_cw_web_inst" {
  alarm_name          = "scaling instances"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Maximum"
  threshold           = "60"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg_web_inst.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.asp_web_inst.arn]
}