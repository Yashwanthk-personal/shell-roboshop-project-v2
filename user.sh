#!/bin/bash

app_name=user
source ./common.sh
check_root

app_setup
nodejs_setup
systemd_setup

restart
total_time