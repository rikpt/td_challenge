#!/bin/sh
yum update
yum install -y docker
service docker start
usermod -aG docker ec2-user
yum install -y python37
curl -O https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py --user
export PATH=/root/.local/bin:$PATH
pip install docker-compose
