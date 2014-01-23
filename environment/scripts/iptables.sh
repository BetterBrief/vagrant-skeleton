#!/bin/bash
#
# iptables example configuration script
#
# Flush all current rules from iptables
#
echo "Setting up secure iptables"
iptables -F
#
# Allow SSH connections on tcp port 22
# This is essential when working on remote servers via SSH to prevent locking yourself out of the system
#
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
#
# Set default policies for INPUT, FORWARD and OUTPUT chains
#
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
#
# Set access for localhost
#
iptables -A INPUT -i lo -j ACCEPT
#
# Accept packets belonging to established and related connections
#
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
#
# Save settings
#
/sbin/service iptables save

/sbin/service iptables restart
#
# List rules
#
iptables -L -v
