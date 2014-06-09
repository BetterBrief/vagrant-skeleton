#!/bin/bash

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


echo "Installing Apache"
yum install -y httpd

echo "Adding Apache service to autostart"
chkconfig httpd on

echo "Copying httpd config"
cp -f /vagrant/environment/config/httpd.conf /etc/httpd/conf/httpd.conf

echo "Mounting webroot"
rm -rf /var/www/html
# pick the webroot
if [ -d /vagrant/www ]
then
	echo "Found folder www, using as webroot"
	WEBROOT="www"
elif [ -d /vagrant/public_html ]
then
	echo "Found folder public_html, using as webroot"
	WEBROOT="public_html"
elif [ -d /vagrant/webroot ]
then
	echo "Found folder webroot, using as webroot"
	WEBROOT="webroot"
else
	echo "Can't find webroot. Quitting..."
	exit 1
fi
ln -s /vagrant/$WEBROOT /var/www/html

if [ -d /var/lib/php/session ]
then
	chown -R vagrant: /var/lib/php/session
fi

echo "Starting httpd service"
service httpd start

echo "Add port 80 to iptables"
iptables -I INPUT 1 -p tcp --dport 80 -j ACCEPT
iptables -I INPUT 1 -p tcp --dport 443 -j ACCEPT
service iptables save

echo "Apache installed"
