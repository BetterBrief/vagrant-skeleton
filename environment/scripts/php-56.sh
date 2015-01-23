#!/bin/bash

echo "Installing PHP 5.6"
rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm

yum install -y php56w php56w-common php56w-pdo php56w-mysqlnd php56w-session php56w-dom php56w-gd php56w-fileinfo php56w-hash php56w-iconv php56w-mbstring php56w-mcrypt php56w-simplexml php56w-tokenizer php56w-xml php56w-tidy

echo "Copying php.ini"
cp -f /vagrant/environment/config/php.ini /etc/php.ini

echo "Restarting Apache"
/sbin/service httpd restart

echo "PHP installed"
