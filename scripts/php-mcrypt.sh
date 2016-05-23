#!/usr/bin/env bash
# This is only required to install mcrypt in php versions < 5.4 on CentOS
# Mcrypt is a common dependency for 5.5+ apps, so it is installed by default with those scripts
# Ensure you include in provisioning AFTER php.sh

PACKAGE_NAME='php-'

echo "Installing Mcrypt php extension"

#install EPEL repo
/vagrant/scripts/epel.sh

if `php -v | grep -Eq 'PHP 5.5'`; then
	PACKAGE_NAME='php55w'
elif `php -v | grep -Eq 'PHP 5.6'`; then
	PACKAGE_NAME='php56w'
fi

yum install -y "${PACKAGE_NAME}-mcrypt" --enablerepo=epel --enablerepo=webtatic

echo "Restarting Apache"
systemctl restart httpd.service

if `php -m | grep -q 'mcrypt'`; then
	echo "mcrypt installed"
else
	echo "Failed to install mcrypt PHP extension successfully"
	exit 1
fi
