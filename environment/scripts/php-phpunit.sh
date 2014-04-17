#!/bin/bash

echo "Installing Pear"
yum install -y php-pear

echo "Adding Pear channels"
pear channel-discover pear.phpunit.de
pear channel-discover pear.symfony.com

echo "Installing PHPUnit 3.7.34 - note this might take a while"
pear install phpunit/PHPUnit-3.7.34

echo "PHPUnit and Pear installed"
