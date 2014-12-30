#!/bin/bash
# This is only required to install mcrypt in php versions < 5.4 on CentOS
# Ensure you include in provisioning AFTER php.sh

echo "Installing Mcrypt php extension"
rpm -ivh http://www.mirrorservice.org/sites/dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum update
yum install -y php-mcrypt

echo "Restarting Apache"
/sbin/service httpd restart

echo "Mcrypt installed"
