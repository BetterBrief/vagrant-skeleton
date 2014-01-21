#!/bin/bash

echo "Installing Grunt & Grunt CLI by NPM"
npm install -y -g grunt-cli

cd /var/www/html
if [ -r "package.json" ]
then
	echo "Installing declared packages from package.json"
	npm install --save-dev --no-bin-links
	echo "Running grunt default"
	grunt default
else
	echo "WARNING: There was no (readable) package.json. Create one and run 'npm install --save-dev --no-bin-links' to install manually."
fi;
