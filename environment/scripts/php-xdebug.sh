#!/bin/bash

echo "Creating xdebug log directory: /var/log/xdebug"
mkdir /var/log/xdebug

echo "Installing XDebug dependencies"
yum install -y php-devel gcc gcc-c++ autoconf automake

echo "Installing XDebug"
pecl install -y Xdebug

echo "Ensuring XDebug is executable"
chmod +x /usr/lib64/php/modules/xdebug.so

echo "Appending xdebug configuration details to /etc/php.ini"
echo "[xdebug]
zend_extension=\"/usr/lib64/php/modules/xdebug.so\"
xdebug.remote_enable = 1" >> /etc/php.ini

echo "Restarting Apache after XDebug installed"
/sbin/service httpd restart
