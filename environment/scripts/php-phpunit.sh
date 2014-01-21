#!/bin/bash

echo "Installing Pear"
yum install -y php-pear

echo "Adding Pear channels"
pear channel-discover pear.phpunit.de
pear channel-discover pear.symfony.com

echo "Installing PHPUnit - note this might take a while"
pear install phpunit/PHPUnit

echo "PHPUnit and Pear installed"
