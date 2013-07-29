#!/bin/bash
#yum update -y

#Apache, PHP & MySQL
sudo yum install -y httpd mysql-server php php-common php-pdo php-mysql php-session php-dom php-gd2 php-fileinfo php-hash php-iconv php-mbstring  php-simplexml php-tokenizer php-xml

sudo chkconfig httpd on
sudo chkconfig mysqld on

#Copy new config files
sudo cp -f /vagrant/environment/httpd.conf /etc/httpd/conf/httpd.conf
sudo cp -f /vagrant/environment/php.ini /etc/php.ini

#Start / restart servers
sudo service httpd restart
sudo service mysqld restart

#Open ports on iptables
sudo cp -f /vagrant/environment/iptables /etc/sysconfig/iptables
sudo service iptables restart

#Repoint /var/www/html to /vagrant/html
sudo rm -rf /var/www/html
sudo ln -s /vagrant/html /var/www/html
