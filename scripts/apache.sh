#!/usr/bin/env bash

## TODOs ##
# Make sure following modules are installed for html5 boilerplate htaccess #
# setenvif
# headers
# mime
# rewrite
# autoindex
# authz_core
# deflate
# filter
# expires
# include

#List of valid webroots in priority order
WEBROOTS=('/vagrant/project/public/' '/vagrant/www/' '/vagrant/public_html/' '/vagrant/webroot/' '/vagrant/public/')


echo "Installing Apache"
yum install -y httpd

echo "Adding Apache service to autostart"
systemctl enable httpd.service

echo "Mounting webroot"
# pick the webroot
for i in ${WEBROOTS[@]}
do
	if [ -d $i ]
	then
		echo "Found Webroot"
		WEBROOT=$i
		break
	fi
done

if [ -z "$WEBROOT" ]
then
	echo "No webroot, installing SS"
	WEBROOT="/vagrant/www"

	/vagrant/scripts/install-silverstripe.sh -d ${WEBROOT}
fi

if [ -d $WEBROOT ]
then
	rm -rf /var/www/html
	ln -s $WEBROOT /var/www/html
fi

# replace the user/group of apache
sed -i 's/User apache/User vagrant/i' /etc/httpd/conf/httpd.conf
sed -i 's/Group apache/Group vagrant/i' /etc/httpd/conf/httpd.conf

# disable sendfile as it can cause problems with VM
sed -i 's/EnableSendfile on/EnableSendfile off/i' /etc/httpd/conf/httpd.conf

# allow overrides in /var/www/html
sed -i '/<Directory "\/var\/www\/html">/,/<\/Directory>/ { s/AllowOverride None/AllowOverride All/i }' /etc/httpd/conf/httpd.conf

if [ -d /var/lib/php/session ]
then
	chown -R vagrant: /var/lib/php/session
fi

echo "Starting httpd service"
systemctl restart httpd.service

echo "Apache installed"
