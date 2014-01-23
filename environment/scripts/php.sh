#!/bin/bash

echo "Installing PHP and common modules"
yum install -y php php-common php-pdo php-mysqlnd php-session php-dom php-gd php-fileinfo php-hash php-iconv php-mbstring php-simplexml php-tokenizer php-xml php-tidy

echo "Copying php.ini"
cp -f /vagrant/environment/config/php.ini /etc/php.ini

echo "Restarting Apache"
/sbin/service httpd restart

echo "PHP installed"
