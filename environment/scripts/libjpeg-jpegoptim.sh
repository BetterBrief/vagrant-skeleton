#!/bin/bash
echo "Installing libjpeg + jpegoptim"
yum install -y libjpeg
echo "libjpeg installed"
echo "Installing jpegoptim from CentALT - note this will modify RPMDB outside of yum"
cd /tmp
mkdir jpegoptim
cd jpegoptim
wget "http://centos.alt.ru/repository/centos/6/x86_64/jpegoptim-1.3.0-1.el6.x86_64.rpm"
rpm -Uvh jpegoptim-1.3.0-1.el6.x86_64.rpm
echo "jpegoptim installed"
