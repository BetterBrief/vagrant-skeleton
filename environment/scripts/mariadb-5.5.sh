#!/bin/bash

echo "Setting up MariaDB"
echo "Writing MariaDB-5.5.repo to /etc/yum.repos.d"
echo "# MariaDB 5.5 CentOS repository list http://mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/5.5/centos6-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1" > /etc/yum.repos.d/MariaDB-5.5.repo

echo "Installing MariaDB server and client. Note there is no progress bar."
yum install -y MariaDB-server MariaDB-client

echo "Adding MariaDB/MySQL service to autostart"
chkconfig mysql on

echo "Starting MariaDB/MySQL service"
/sbin/service mysql start

echo "Add port 3306 to iptables"
iptables -I INPUT 1 -p tcp --dport 3306 -j ACCEPT
/sbin/service iptables save

# find the DB folder
if [ -d /vagrant/database ]
then
	echo "Found folder 'database', using as db folder"
	DATABASE_FOLDER="database"
elif [ -d /vagrant/db ]
then
	echo "Found folder db, using as db folder"
	DATABASE_FOLDER="db"
else
	echo "Can't find db folder. Quitting..."
	exit 1
fi

DB_FILES=/vagrant/$DATABASE_FOLDER/*.sql
shopt -s nullglob
for file in $DB_FILES
do
	DB_NAME=`basename $file .sql`
	echo "Creating database '$DB_NAME'"
	# Drop the DB so that we can run the provisioner on a machine that already has had it run once
	mysql -u root <<< "DROP DATABASE IF EXISTS \`$DB_NAME\`; CREATE DATABASE IF NOT EXISTS \`$DB_NAME\`;"

	echo "Importing database dump"
	sed '/^CREATE DATABASE/d;/^USE/d' $file | mysql $DB_NAME -u root
done;

echo "Databases imported"


#Reload the database
echo "Setting DB permissions for root"
mysql -u root <<< "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"

echo "MariaDB installed"
