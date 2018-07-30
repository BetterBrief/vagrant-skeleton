#!/usr/bin/env bash

echo "Installing NodeJS (CentOS method)"

echo "Installing NodeJS + NPM with EPEL"

curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -

yum install -y nodejs

#turn off bin links by default
npm config set bin-links false
