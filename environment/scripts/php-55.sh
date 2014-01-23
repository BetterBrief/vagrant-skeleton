#!/bin/bash

echo "Installing PHP 5.5"
rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm

yum install -y php55w php55w-common php55w-pdo php55w-mysqlnd php55w-session php55w-dom php55w-gd php55w-fileinfo php55w-hash php55w-iconv php55w-mbstring php55w-simplexml php55w-tokenizer php55w-xml php55w-tidy

echo "Copying php.ini"
cp -f /vagrant/environment/config/php.ini /etc/php.ini

echo "Restarting Apache"
/sbin/service httpd restart

echo "PHP installed"
