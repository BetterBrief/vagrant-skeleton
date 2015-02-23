#!/bin/bash

PHP_NAME="php56w"

# declare the php modules we want
MODULES=(common mysql gd mbstring xml)

/vagrant/scripts/epel.sh

echo "Installing PHP and common modules"
yum install -y $PHP_NAME ${MODULES[@]/#/$PHP_NAME-} --enablerepo=epel --enablerepo=webtatic

# use the dev php.ini file
cp -f /usr/share/doc/$PHP_NAME-*/php.ini-development /etc/php.ini

# set the date/time
sed -i 's/;date\.timezone.*/date\.timezone = UTC/g' /etc/php.ini
sed -i 's/memory_limit.*/memory_limit = 256M/g' /etc/php.ini

echo "Restarting Apache"
systemctl start httpd.service

echo "PHP installed"
