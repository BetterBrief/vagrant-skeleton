#!/usr/bin/env bash

echo "Installing MariaDB"
yum install -y mariadb-server

echo "Adding MariaDB service to autostart"
systemctl enable mariadb.service

echo "Starting MariaDB service"
systemctl start mariadb.service

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

DEL_FILES=()
#extract .sql.gz files - these need to be cleaned up afterwards!
GZ_FILES=/vagrant/$DATABASE_FOLDER/*.sql.gz
shopt -s nullglob
for file in $GZ_FILES
do
	FILENAME=`basename $file .gz`
	gunzip -c -v $file > /vagrant/$DATABASE_FOLDER/$FILENAME
	DEL_FILES+=("/vagrant/$DATABASE_FOLDER/$FILENAME")
done;

BZ2_FILES=/vagrant/$DATABASE_FOLDER/*.sql.bz2
shopt -s nullglob
for file in $BZ2_FILES
do
	FILENAME=`basename $file .bz2`
	bzip2 -dkc $file > /vagrant/$DATABASE_FOLDER/$FILENAME
	DEL_FILES+=("/vagrant/$DATABASE_FOLDER/$FILENAME")
done;

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

for file in $DEL_FILES
do
	rm -f $file
done;

echo "Databases imported"


#Reload the database
echo "Setting DB permissions for root"
mysql -u root <<< "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"

echo "MariaDB installed"
