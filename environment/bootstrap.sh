#!/bin/bash
#yum update -y

#Apache, PHP & MySQL
if [ ! -f ~/runbefore ]
then
	sudo yum install -y httpd mysql-server php php-common php-pdo php-mysql php-session php-dom php-gd2 php-fileinfo php-hash php-iconv php-mbstring  php-simplexml php-tokenizer php-xml
	sudo chkconfig httpd on
	sudo chkconfig mysqld on
fi

#Copy new config files
sudo cp -f /vagrant/environment/httpd.conf /etc/httpd/conf/httpd.conf
sudo cp -f /vagrant/environment/php.ini /etc/php.ini
sudo cp -f /vagrant/environment/_ss_environment.php /var/www/_ss_environment.php

#Start / restart servers
sudo service httpd restart
sudo service mysqld restart

#Open ports on iptables
sudo cp -f /vagrant/environment/iptables /etc/sysconfig/iptables
sudo service iptables restart

#Repoint /var/www/html to /vagrant/trunk
sudo rm -rf /var/www/html
sudo ln -s /vagrant/www /var/www/html
#sudo cp -f /vagrant/environment/ /var/www/html

if [ ! -f ~/runbefore ]
then
	#Reload the database
    echo "Loading the database dump"
    mysql -u root < /vagrant/database/database_dump.sql
    #mysql -u root <<< "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"

    #Fixing slow curl requests (ipv6 resolving timeouts causing issue)
	#See: https://github.com/mitchellh/vagrant/issues/1172
	if [ ! $(grep single-request-reopen /etc/resolv.conf) ];
		then echo 'options single-request-reopen' >> /etc/resolv.conf && service network restart;
	fi
fi

#Leaving something for us to detect this has all run before
touch ~/runbefore