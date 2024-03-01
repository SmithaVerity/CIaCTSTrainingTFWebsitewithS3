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


