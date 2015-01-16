#!/bin/bash

echo "Installing Grunt & Grunt CLI by NPM"
npm install -y -g grunt-cli

if [ -r "/var/www/html/package.json" ]
then
	echo "Installing declared packages from package.json"
	npm install --save-dev --no-bin-links /var/www/html
	echo "Running grunt default (with --force if this is an empty project)"
	grunt default --force --base /var/www/html --gruntfile /var/www/html/Gruntfile.js
else
	echo "WARNING: There was no (readable) package.json. Create one and run 'npm install --save-dev --no-bin-links' to install manually."
fi;
