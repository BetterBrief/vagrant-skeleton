#!/bin/bash

echo "Installing mod_xsendfile for Apache2 (httpd-devel required)"
yum install -y httpd-devel
cd /tmp
wget -O mod_xsendfile.tar.gz https://codeload.github.com/nmaier/mod_xsendfile/tar.gz/0.12
tar -zxf mod_xsendfile.tar.gz
cd mod_xsendfile-0.12/
apxs -cia mod_xsendfile.c

cp /vagrant/environment/config/xsendfile.conf /etc/httpd/conf.d/xsendfile.conf

service httpd restart
