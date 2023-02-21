#!/bin/bash

sudo yum update -y
sudo yum install httpd -y


TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"` \
&& PRIVATE_IP=`curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4`

chmod -R 777 /var/www/html

sudo echo "<html>
<head>
    <title> Application Load Balancer</title>
</head>
<body>
    <h1>Welcome to Mehmet's page. Private IP address of this instance is $PRIVATE_IP</h1>
</body>
</html>" > /var/www/html/index.html

sudo systemctl enable httpd
sudo systemctl start httpd

