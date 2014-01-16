#!/bin/bash

echo "Installing ntp"

yum install -y ntp

echo "Syncing ntp"

ntpdate europe.pool.ntp.org

echo "Adding ntpd to startup services"

chkconfig ntpd on

echo "Starting ntpd"

service ntpd start

echo "Done install ntp"
