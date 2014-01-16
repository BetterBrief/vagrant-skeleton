#!/bin/bash

echo "Installing Pear"
yum install -y php-pear

echo "Adding Pear channels"
pear channel-discover pear.phpunit.de
pear channel-discover pear.symfony.com

echo "Installing PHPUnit"
pear install phpunit/PHPUnit

echo "PHPUnit and Pear installed"
