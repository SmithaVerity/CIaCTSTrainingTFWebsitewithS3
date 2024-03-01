#!/bin/bash

set -e

# Update packages on the system

sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl enable apache2
sudo wget https://s3.amazonaws.com/mountpoint-s3-release/latest/x86_64/mount-s3.deb
sudo apt-get install ./mount-s3.deb -y
sudo rm -f ./mount-s3.deb
sudo mkdir /mount_s3
sudo mount-s3 ${module.s3.s3_bucket_id} /mount_s3
git clone https://github.com/SmithaVerity/ABTestingApp.git
mv ABTestingApp/cafe /var/www/html


