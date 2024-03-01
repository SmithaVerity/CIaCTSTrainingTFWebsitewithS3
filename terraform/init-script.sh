#!/bin/bash

set -e

# Update packages on the system
sudo -s
apt-get update
apt-get install -y apache2
systemctl enable apache2
wget https://s3.amazonaws.com/mountpoint-s3-release/latest/x86_64/mount-s3.deb
apt install ./mount-s3.deb -y
rm -f ./mount-s3.deb
mkdir /mount_s3
mount-s3 ${module.s3.s3_bucket_id} /mount_s3

  git clone https://github.com/SmithaVerity/ABTestingApp.git

  mv ABTestingApp/cafe /var/www/html

