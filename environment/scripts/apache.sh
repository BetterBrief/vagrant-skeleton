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
# pick the webroot
if [ -d /vagrant/project/public ]
then
	echo "Found Laravel style project/public directory, using as webroot"
	WEBROOT="/vagrant/project/public"
elif [ -d /vagrant/www ]
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
fi

if [ -d /vagrant/$WEBROOT ]
then
	rm -rf /var/www/html
	ln -s /vagrant/$WEBROOT /var/www/html
fi

if [ -d /var/lib/php/session ]
then
	chown -R vagrant: /var/lib/php/session
fi

echo "Starting httpd service"
service httpd restart

echo "Add port 80 to iptables"
iptables -I INPUT 1 -p tcp --dport 80 -j ACCEPT
iptables -I INPUT 1 -p tcp --dport 443 -j ACCEPT
service iptables save

echo "Apache installed"
