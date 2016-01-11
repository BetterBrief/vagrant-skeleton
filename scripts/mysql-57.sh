#!/usr/bin/env bash

yum -y localinstall http://dev.mysql.com/get/mysql57-community-release-el7-7.noarch.rpm

yum -y install mysql-community-server

systemctl start mysqld

PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | sed 's/.* //g')

mysql -p"${PASSWORD}" -e "update mysql.user set password=PASSWORD('') where user='root';"

systemctl restart mysqld
