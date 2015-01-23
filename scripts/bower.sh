#!/bin/bash

# Install bower
echo "Installing bower"
npm install -g bower

echo "Bower installed"

for themedir in /var/www/html/themes/*
do
	if [ -r "$themedir/bower.json" ]
	then
		bower install --allow-root --config.cwd=$themedir
	fi
done
