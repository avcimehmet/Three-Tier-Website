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

  desired_capacity = local.total_instance_count
  min_size         = local.total_instance_count
  max_size         = local.total_instance_count * 2

  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }

  tag {
    key                 = "Name"
    value               = "Web-Server"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_attachment" "asa_asg_web" {
  autoscaling_group_name = aws_autoscaling_group.asg_web_inst.id
  lb_target_group_arn    = aws_lb_target_group.Lb_target_group.arn
}

resource "aws_autoscaling_policy" "asp_scale_out_web_inst" {
  name                   = "asp_scale_out_web_inst"
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "StepScaling"
  autoscaling_group_name = aws_autoscaling_group.asg_web_inst.name

  step_adjustment {
    scaling_adjustment          = 1
    metric_interval_lower_bound = 1.0
  }
}

resource "aws_autoscaling_policy" "asp_scale_in_web_inst" {
  name                   = "asp_scale_in_web_inst"
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "StepScaling"
  autoscaling_group_name = aws_autoscaling_group.asg_web_inst.name

  step_adjustment {
    scaling_adjustment          = -1
    metric_interval_upper_bound = -1.0
  }
}

resource "aws_cloudwatch_metric_alarm" "cw_scale_out_web_inst" {
  alarm_name          = "scale-out"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "70"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg_web_inst.name
  }

  alarm_description = "This metric is to scale-out according to ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.asp_scale_out_web_inst.arn]
}

resource "aws_cloudwatch_metric_alarm" "cw_scale_in_web_inst" {
  alarm_name          = "scale-in"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "60"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg_web_inst.name
  }

  alarm_description = "This metric is to scale-in according to ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.asp_scale_in_web_inst.arn]
}