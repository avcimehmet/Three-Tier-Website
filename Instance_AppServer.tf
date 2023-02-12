resource "aws_instance" "App_Server" {
  count                  = 1 #var.App_instance_count
  ami                    = data.aws_ami.amzlinux.id
  instance_type          = var.instance_type
  subnet_id              = element(local.subnets, 1)
  vpc_security_group_ids = [aws_security_group.Website-deployment-AppServer.id]

  user_data = templatefile("./userdata-apache.sh", {
    file_content = "App Server version 1.2 - ${count.index}"
  })

  tags = {
    Name                  = "AppServer ${count.index + 1} (v${var.infrastructure_version})"
    InfrastructureVersion = var.infrastructure_version
  }
}
