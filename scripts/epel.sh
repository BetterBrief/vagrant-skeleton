#!/bin/bash

if [ ! -f /etc/yum.repos.d/epel.repo ]; then
	echo "Installing Webtatic"
	rpm -i https://mirror.webtatic.com/yum/el7/epel-release.rpm
	rpm -i https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
	sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/epel.repo
	sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/webtatic.repo
fi
