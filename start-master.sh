#! /bin/bash
sudo apt-get -y update
sudo apt  install -y docker.io
sudo apt install -y ruby-full
sudo apt install -y wget
wget https://aws-codedeploy-us-west-2.s3.us-west-2.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo apt  install -y awscli