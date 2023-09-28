resource "aws_instance" "App_Server" {
  count                  = var.Subnet_count * var.Instance_count_per_subnet
  ami                    = data.aws_ami.amzlinux.id
  instance_type          = var.instance_type
  subnet_id              = element(local.subnets_private, count.index)
  vpc_security_group_ids = [aws_security_group.Website-deployment-AppServer.id]
  key_name               = "key-needed"

  user_data = templatefile("./userdata-AppServer.sh", {
    file_content = "App Server version 1.2 - ${count.index}"
  })

  tags = {
    Name                  = "AppServer ${count.index + 1} (v${var.infrastructure_version})"
    InfrastructureVersion = var.infrastructure_version
  }
}
