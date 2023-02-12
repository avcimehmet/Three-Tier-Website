#!/bin/bash

sudo yum update -y
sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd

sudo echo "<h1>Mehmet's Website WebServer</h1>" > /var/www/html/index.html