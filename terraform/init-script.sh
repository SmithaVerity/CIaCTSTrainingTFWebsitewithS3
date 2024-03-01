#!/bin/bash

set -e

# Update packages on the system

sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl enable apache2
sudo apt-get install awscli -y
sudo apt-get install s3fs -y
git clone https://github.com/SmithaVerity/ABTestingApp.git
mv ABTestingApp/cafe /var/www/html
sudo mkdir /home/ubuntu/bucket
cd /home/ubuntu/bucket
sudo touch test1.txt test2.txt test3.txt
aws s3 sync /home/ubuntu/bucket s3://${module.s3.s3_bucket_id}
sudo s3fs ${module.s3.s3_bucket_id} /home/ubuntu/bucket -o iam_role=${var.environment}_ec2_role -o use_cache=/tmp -o nonempty -o allow_other -o uid=1001 -o mp_umask=002 -o multireq_max=5 -o use_path_request_style -o url=https://s3-ap-south-1.amazonaws.com -o dbglevel=info -f -o curldbg


