#!/bin/bash

echo "Installing GeoIP"

echo "Adding fedora RPM for GeoIP"
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

yum install -y php-pear php-devel httpd-devel GeoIP GeoIP-devel

echo "Installing GeoIP php module"
pecl install geoip

echo "Downloading GeoIP database"
mkdir /var/lib/GeoIP
wget -N http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz
gunzip GeoIP.dat.gz
mv GeoIP.dat /var/lib/GeoIP

echo "Setting up SELinux policy"
chcon -t httpd_sys_content_t /var/lib/GeoIP
chcon -t httpd_sys_content_t /var/lib/GeoIP/*
chcon system_u:object_r:textrel_shlib_t /usr/lib64/php/modules/geoip.so

echo "Adding PHP extension"
echo "extension=geoip.so" >> /etc/php.d/geoip.ini

echo "Restarting Apache"
/sbin/service httpd restart

echo "GeoIP installed"
