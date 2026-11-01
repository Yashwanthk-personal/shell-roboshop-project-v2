#!/bin/bash

source ./common.sh

check_root

dnf module disable redis -y &>> $logs_file
dnf module enable redis:7 -y &>> $logs_file
dnf install redis -y &>> $logs_file
validate $? "Installing Redis"

sed -i -e 's/^bind 127.0.0.1/bind 0.0.0.0/' -e 's/^protected-mode yes/protected-mode no/' /etc/redis/redis.conf
validate $? "Allowing remote connections to Redis"

systemctl enable redis &>> $logs_file
systemctl start redis
validate $? "Enable and start Redis"

total_time