#!/bin/bash

REMOVE_DIR=false

echo "Installing libjpeg + jpegoptim"
yum install -y libjpeg
echo "libjpeg installed"
echo "Installing jpegoptim from CentALT - note this will modify RPMDB outside of yum"
if [ ! -d /tmp/jpegoptim ]; then
	mkdir /tmp/jpegoptim
	REMOVE_DIR=true
fi
cd /tmp/jpegoptim
wget "http://centos.alt.ru/repository/centos/6/x86_64/jpegoptim-1.3.0-1.el6.x86_64.rpm"
rpm -Uvh jpegoptim-1.3.0-1.el6.x86_64.rpm
rm -f jpegoptim-1.3.0-1.el6.x86_64.rpm
if [ $REMOVE_DIR ]; then
	rm -rf /tmp/jpegoptim
fi
echo "jpegoptim installed"
