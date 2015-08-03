#!/usr/bin/env bash

echo "Starting BB bootstrap"

#Fixing slow curl requests (ipv6 resolving timeouts causing issue)
#See: https://github.com/mitchellh/vagrant/issues/1172
if [ ! "$(grep single-request-reopen /etc/resolv.conf)" ];
	then echo 'options single-request-reopen' >> /etc/resolv.conf && systemctl restart network;
fi

echo "Bootstrap complete"
