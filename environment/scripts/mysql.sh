#!/bin/bash

echo "Installing MySQL"
yum install -y mysql-server

echo "Adding MySQL service to autostart"
sudo chkconfig mysqld on

echo "Starting MySQL service"
service mysqld start

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

echo "MySQL installed"
