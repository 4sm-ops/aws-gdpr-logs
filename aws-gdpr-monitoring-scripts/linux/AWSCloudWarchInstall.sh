#!/bin/bash
sudo yum update -y
sudo yum install -y awslogs

EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
EC2_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed 's/[a-z]$//'`"

sudo sed -i -e "s/region = us-east-1/region = $EC2_REGION/g" /etc/awslogs/awscli.conf

#echo $EC2_AVAIL_ZONE
#echo $EC2_REGION

sudo service awslogs start
sudo chkconfig awslogs on
