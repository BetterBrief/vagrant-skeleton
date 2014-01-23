#!/bin/bash

echo "Installing APC for php"
yum install -y php-pear php-devel httpd-devel pcre-devel gcc make

echo "Installing apc module for PHP"
# printf helps skip the prompts from the installer - http://stackoverflow.com/a/8154466
printf "\n" | pecl install apc

echo "Adding APC to php config"
echo "extension = apc.so" >> /etc/php.d/apc.ini

echo "Restarting Apache"
/sbin/service httpd restart

echo "APC Installed"
