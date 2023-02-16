resource "aws_launch_configuration" "asg_web" {
  count         = "${local.total_instance_count}"
  name_prefix   = "lc-Three-Tier"
  image_id      = data.aws_ami.amzlinux.id
  instance_type = "t2.micro"

  user_data = templatefile("./userdata-WebServer.sh", {
    file_content = "Web Server version 1.2 - ${count.index+"${local.total_instance_count}"}"
  })

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_launch_template" "asg_web" {
  count         = "${local.total_instance_count}"
  name          = "lt-Three-Tier-web-inst-${count.index}"
  image_id      = data.aws_ami.amzlinux.id
  instance_type = "t2.micro"
  key_name      = "mykey"


  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.Website-deployment-WebServer.id]
    delete_on_termination       = true
    subnet_id                   = "${aws_subnet.Website-deployment-public["${count.index}"].id}"
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }
}

resource "aws_autoscaling_group" "asg_web_inst" {
  count                = "${local.total_instance_count}"
  name                 = "asg-Three-Tier-web-inst-${count.index}"
  vpc_zone_identifier  = [aws_subnet.Website-deployment-public["${count.index}"].id]
  force_delete         = true

  desired_capacity     = "${local.total_instance_count}"
  min_size             = ((var.Subnet_count * var.Instance_count_per_subnet)-1)
  max_size             = var.Subnet_count * var.Instance_count_per_subnet * 2

  launch_template {
    id      = aws_launch_template.asg_web[count.index].id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [load_balancers, target_group_arns]
  }
}

resource "aws_autoscaling_attachment" "asg_web" {
  count                  = "${local.total_instance_count}"
  autoscaling_group_name = aws_autoscaling_group.asg_web_inst["${count.index}"].id
  lb_target_group_arn    = aws_lb_target_group.Lb_target_group.arn
}