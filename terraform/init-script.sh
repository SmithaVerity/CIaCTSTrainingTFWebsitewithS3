#!/bin/bash

set -e

sudo -s

  # Update packages on the system
  apt-get update

  # Install S3 Mount
  wget https://s3.amazonaws.com/mountpoint-s3-release/latest/x86_64/mount-s3.deb
  apt install ./mount-s3.deb -y
  rm -f ./mount-s3.deb

  # Create mount point directory
  mkdir /mount_s3
  mount-s3 ${module.s3.s3_bucket_id} /mount_s3
