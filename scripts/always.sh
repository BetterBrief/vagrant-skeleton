#!/usr/bin/env bash

echo "starting httpd"
systemctl start httpd.service

if [ -x /usr/local/bin/mailcatcher ]; then
	/usr/local/bin/mailcatcher --ip=0.0.0.0
fi
