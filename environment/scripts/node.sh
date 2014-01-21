#!/bin/bash

echo "Installing NodeJS (CentOS method)"
echo "Downloading Ferodra EPEL repo"
curl -O http://download-i2.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
echo "Installing EPEL"
rpm -ivh epel-release-6-8.noarch.rpm
echo "Installing NodeJS + NPM with EPEL"
yum install -y npm --enablerepo=epel
rm -f epel-release-6-8.noarch.rpm
