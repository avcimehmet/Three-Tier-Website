# Three-Tier-Website
My website running on AWS in 3 Tier architecture with RDS storage (Created by Terraform).


Problems to be Solved:
1.  AppServers on private subnets may have a connection problem to the NAT_gw.
2.  "userdata-AppServer.sh" file is not functioning during the "Terraform apply" process. After connecting to the instance, when I manually run the installation commands, I see the index.html file created under "/var/www/html/" folder surprisingly.

Deficiencies Detected and Applied Solution:
1.  Route Table created for NATgw
2.  Route Table Association (to private subnets) created for NATgw

#ALB & ASG created.
Problems to be Solved:
1.  LB target group registration could not be completed due to a bad "arn".

Deficiencies Detected and Applied Solution:
1.  aws_lb_target_group_attachment is having conflict with "aws_autoscaling_attachment"
2.  aws_lb_target_group_attachment is removed. 
