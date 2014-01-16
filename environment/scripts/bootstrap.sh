#!/bin/bash

echo "Starting BB bootstrap"

#Open ports on iptables
echo "Setting up default iptables"


#Fixing slow curl requests (ipv6 resolving timeouts causing issue)
#See: https://github.com/mitchellh/vagrant/issues/1172
if [ ! $(grep single-request-reopen /etc/resolv.conf) ];
	then echo 'options single-request-reopen' >> /etc/resolv.conf && service network restart;
fi

echo "Bootstrap complete"
