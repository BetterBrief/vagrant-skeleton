#!/usr/bin/env bash

echo "starting httpd"
systemctl start httpd.service

if [ -x /usr/local/bin/mailcatcher ]; then
	echo "Starting mailcatcher"
	/usr/local/bin/mailcatcher --ip=0.0.0.0
fi

if [ -d /var/www/html/silverstripe-cache ]; then
	echo "Clearing SS site cache"
    rm -rf /var/www/html/silverstripe-cache/*
fi
